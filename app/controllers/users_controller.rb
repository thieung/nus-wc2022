class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:pick_champion, :change_status]
  before_action :load_user, only: [:statistics, :change_status]

  def change_status
    authorize! :manage, current_user
    @user.is_active = !@user.is_active
    @user.save
  end

  def statistics
    @user_statistics = []

    @user.bets.has_score.ordered.includes(:game).each do |bet|
      tmp = {
        game: bet.game,
        scores: bet.score_ids.size,
        money_bet: bet.total_money_bet,
        money_win: bet.total_money_win,
        money_get: bet.total_money_win - bet.total_money_bet
      }
      @user_statistics << tmp
    end
    @maximum_money_win = @user_statistics.sort{|a,b| b[:money_win] <=> a[:money_win]}.first[:money_win]
  end

  def predict_champion
    @predict_stats = if DateTime.current < DateTime.parse(Settings.predict_champion_deadline.first)
      {
        collection: PredictChampion.has_team,
        total_money: PredictChampion.has_team.sum(:money)
      }
    else
      {
        collection: PredictChampion,
        total_money: PredictChampion.sum(:money)
      }
    end

    if DateTime.current > DateTime.parse(Settings.final_match_time)
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
    if DateTime.current <= DateTime.parse(Settings.predict_champion_deadline.first)
      valid_predict = true
      valid_predict = !current_user.predict_champions.exists?(team_id: params[:team_id])
      valid_predict = !Team.find_by(id: params[:team_id]).eliminated
      if valid_predict
        predict_champion = current_user.predict_champions.new(
          team_id: params[:team_id],
          money: 100000
        )
        unless predict_champion.save
          err_msg = predict_champion.errors.full_messages.first
        end
      else
        err_msg = "Có lỗi xảy ra, vui lòng kiểm tra lại đội bóng mà bạn đã chọn!"
      end
    else
      err_msg = "Đã quá hạn deadline, bạn không thể dự đoán đội vô địch!"
    end
    flash[:alert] = err_msg if err_msg.present?
    redirect_to predict_champion_path
  end

  private

  def load_user
    @user = User.find_by(id: params[:id])
  end
end
