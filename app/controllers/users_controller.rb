class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:pick_champion, :change_status, :import_predict_champion, :new, :create]
  before_action :load_user, only: [:statistics, :change_status, :import_predict_champion]

  def new
    authorize! :manage, current_user
    @user = User.new
  end

  def create
    authorize! :manage, current_user
    @user = User.new(user_params)
    @user.username = user_params[:email].split('@').try(:first).try(:downcase) if user_params[:email]

    generated_password = Devise.friendly_token.first(8)
    @user.password = generated_password

    if @user.save
      @user.add_role :staff
      UserMailer.delay.send_password_to_staff(@user, generated_password) unless Settings.is_turn_off_mail

      if params[:can_join_to_predict_champion]
        # Generate predict champion data for new staff
        predict = @user.predict_champions.new(money: Settings.predict_champion_money.first)
        predict.save
      end

      redirect_to management_path and return
    else
      render :new
    end
  end

  def change_status
    authorize! :manage, current_user
    @user.is_active = !@user.is_active
    @user.save
  end

  def statistics
    @user_statistics = []

    @user.bets.has_score.joins(:game).order("games.play_at ASC").each do |bet|
      @user_statistics <<  {
        game: bet.game,
        scores: bet.score_ids.size,
        money_bet: bet.total_money_bet,
        money_win: bet.total_money_win,
        money_get: bet.total_money_win - bet.total_money_bet
      }
    end
    @maximum_money_win = @user_statistics.sort{|a,b| b[:money_win] <=> a[:money_win]}.first[:money_win] rescue 0
  end

  def predict_champion
    load_predict_stats

    if finish_tournament?
      # Show result
      money_for_champion = Settings.nus_money_for_champion.to_i + PredictChampion.sum(:money)
      winner_ids = PredictChampion.joins(:team).where("teams.is_champion" => true).map(&:user_id).uniq
      unless winner_ids.blank?
        @winner_list = User.where(id: winner_ids)
        @money_for_each_user = (money_for_champion.to_f/winner_ids.size).round
      end
    end
  end

  def pick_champion
    err_msg = ''
    if current_user.available_to_predict_champion?
      valid_predict = true
      valid_predict = !current_user.predict_champions.exists?(team_id: params[:team_id])
      valid_predict = !Team.find_by(id: params[:team_id]).eliminated
      if valid_predict
        predict_champion = if can_predict_before_group_stage?
          current_user.predict_champions.first
        else
          current_user.predict_champions.new
        end

        predict_champion.team_id = params[:team_id]
        money_rate = Settings.predict_champion_money.first
        if can_predict_before_round_of_16?
          money_rate = Settings.predict_champion_money.second
        end
        if can_predict_before_quarter_final?
          money_rate = Settings.predict_champion_money.third
        end

        predict_champion.money = money_rate

        unless predict_champion.save
          err_msg = predict_champion.errors.full_messages.first
        else
          Mailer.process_notice_predict_champion_result_to_staffs(predict_champion) unless Settings.is_turn_off_mail
        end
      else
        err_msg = "C?? l???i x???y ra, vui l??ng ki???m tra l???i ?????i b??ng m?? b???n ???? ch???n!"
      end
    else
      err_msg = "???? qu?? h???n deadline, b???n kh??ng th??? d??? ??o??n ?????i v?? ?????ch!"
    end
    flash[:alert] = err_msg if err_msg.present?
    redirect_to predict_champion_path
  end

  def import_predict_champion
    authorize! :manage, current_user
    predict_champion = if DateTime.current <= DateTime.parse(Settings.predict_champion_deadline.first)
      @user.predict_champions.first
    else
      @user.predict_champions.new
    end

    @success = false
    unless params[:predict_team_id].blank?
      predict_champion.team_id = params[:predict_team_id]

      money_rate = Settings.predict_champion_money.first
      if can_predict_before_round_of_16?
        money_rate = Settings.predict_champion_money.second
      end
      if can_predict_before_quarter_final?
        money_rate = Settings.predict_champion_money.third
      end

      predict_champion.money = money_rate
      @success = predict_champion.save
      load_predict_stats
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name)
  end

  def load_user
    @user = User.find_by(id: params[:id])
  end

  def load_predict_stats
    @users_indexed = User.staffs.index_by(&:id)
    @teams_indexed = Team.join_tournament.index_by(&:id)
    @predict_stats = if DateTime.current <= DateTime.parse(Settings.predict_champion_deadline.first)
      {
        collection: PredictChampion.has_team,
        total_money: PredictChampion.has_team.sum(:money)
      }
    else
      {
        collection: PredictChampion.all,
        total_money: PredictChampion.sum(:money)
      }
    end

    @number_of_rows = if finish_round_of_16?
                        3
                      elsif finish_group_stage?
                        2
                      else
                        1
                      end

    @staffs = User.staffs.joins(:predict_champions).includes(predict_champions: :team).order(:username).uniq
  end
end
