class MatchesController < ApplicationController
  before_action :load_match, only: [:show, :check_valid_match, :predict_score, :predict_score_edit_view, :update_betting_scores, :update_match_score, :import_user_betting_scores, :import_number_users, :update_score, :future_match_update_info]
  before_action :check_valid_match, only: [:show, :update_betting_scores, :update_match_score, :import_user_betting_scores, :import_number_users, :update_score]
  before_action :authenticate_user!, only: [:predict_score, :predict_score_edit_view, :update_betting_scores, :update_match_score, :import_user_betting_scores, :import_number_users, :update_score, :future_match_update_info]

  def index
    today   = Date.today
    @groups = Group.all.index_by(&:id)
    @rounds = Round.all.index_by(&:id)
    @teams  = Team.all.index_by(&:id)
    @type = params[:type]||'all_matches'
    @games = Game.send(@type)

    if params[:type].blank?
      if Date.parse(Settings.group_stage.start) <= today && today >= Date.parse(Settings.group_stage.end)
        redirect_to matches_path({type: 'group_stage'}) and return
      elsif Date.parse(Settings.round_of_16.start) <= today && today >= Date.parse(Settings.round_of_16.end)
        redirect_to matches_path({type: 'round_of_16'}) and return
      elsif Date.parse(Settings.quarter_final.start) <= today && today >= Date.parse(Settings.quarter_final.end)
        redirect_to matches_path({type: 'quarter_final'}) and return
      elsif Date.parse(Settings.semi_final.start) <= today && today >= Date.parse(Settings.semi_final.end)
        redirect_to matches_path({type: 'semi_final'}) and return
      elsif Date.parse(Settings.final.start) <= today && today >= Date.parse(Settings.final.end)
        redirect_to matches_path({type: 'final'}) and return
      end
    end
    @all_matches = @games.select("games.*, date(play_at) as occur_date").order("occur_date").group_by(&:occur_date)
  end

  def show
    @money_statistic = calculate_money_for_match @game
    if @game.has_score?
      winners_ids = @game.bets.select{|b| b.score_ids.map(&:to_i).include?(@game.score_id)}.map(&:user_id).uniq
      @winners = User.includes(:bets).where("users.id"=>winners_ids)
    end
  end

  def predict_score
    return unless @game.available_to_bet
    score_ids = if params[:match].blank? || params[:match][:score_ids].blank?
      []
    else
      params[:match][:score_ids]
    end
    bet_info = current_user.get_bet_info_on_match(params[:id])||current_user.bets.new(game_id: @game.id)
    if score_ids.size > 3
      @err_msg = "Bạn không được dự đoán quá 3 tỉ số"
    else
      bet_info.score_ids = score_ids
      bet_info.last_changed_at = DateTime.current
      bet_info.total_money_bet = score_ids.size * @game.round.money_rate
      unless bet_info.save
        @err_msg = bet_info.errors.full_message.first
      else
        @money_statistic = calculate_money_for_match @game
      end
    end
  end

  def predict_score_edit_view
  end

  def update_betting_scores
    authorize! :manage, current_user
  end

  def update_match_score
    authorize! :manage, current_user
  end

  def import_user_betting_scores
    authorize! :manage, current_user
    return if !current_user.is_admin? && !@game.available_to_bet
    success = false
    Game.transaction do
      users_indexed = User.all.index_by(&:id)
      params[:bet_info].each do |item|
        user_id = item[1][:user_id]
        score_ids = item[1][:score_ids]
        user = users_indexed[user_id.to_i]
        if user_id.present? && score_ids.present?
          bet_info = user.get_bet_info_on_match(@game.id)||user.bets.new(game_id: @game.id)
          if score_ids.size > 3
            raise ActiveRecord::Rollback
          else
            bet_info.score_ids = score_ids
            bet_info.last_changed_at = DateTime.current
            bet_info.total_money_bet = score_ids.size * @game.round.money_rate
            if bet_info.save
              success = true
            else
              raise ActiveRecord::Rollback
            end
          end
        end
      end
    end
    flash[:alert] = "Có lỗi xảy ra, vui lòng nhập lại!" unless success
    redirect_to match_path(@game) and return
  end

  def import_number_users
    authorize! :manage, current_user
    @number = params[:number_user].to_i
  end

  def add_row
    authorize! :manage, current_user
  end

  def update_score
    authorize! :manage, current_user
    # if DateTime.current < (@game.play_at + 90.minutes)
    if false
      @err_msg = "Trận đấu chưa kết thúc, bạn chưa thể cập nhật tỉ số trận đấu này."
    else
      score = Score.find_by_id params[:score_id]
      if score
        score_result = score.name.split('-')
        score_team1 = score_result[0].to_i
        score_team2 = score_result[1].to_i
        winner_team_id = if score_team1 > score_team2
          @game.team1_id
        elsif score_team1 < score_team2
          @game.team2_id
        else
          nil
        end
        success = @game.update_attributes(
          score1: score_team1,
          score2: score_team2,
          score_id: score.id,
          locked: true,
          winner: winner_team_id
        )
        unless success
          @err_msg = "Không thể cập nhật kết quả trận đấu, vui lòng kiểm tra lại."
        end
      end
    end
    flash[:alert] = @err_msg if @err_msg
    redirect_to match_path(@game)
  end

  def future_match_update_info
    authorize! :manage, current_user
    @success = false
    if params[:tmp_team1_id].present? && params[:tmp_team2_id].present?
      @game.team1_id = params[:tmp_team1_id]
      @game.team2_id = params[:tmp_team2_id]
      @success = @game.save
    end
  end

  private

  def match_params
    params[:match].permit!(:score_ids)
  end

  def load_match
    @game = Game.find_by id: params[:id]
  end

  def check_valid_match
    unless @game.can_bet?
      flash[:alert] = "Bạn chưa thể xem được thông tin trận đấu này."
      redirect_to root_path and return
    end
    if action_name != 'show' && @game.locked
      flash[:alert] = "Trận đấu này đã diễn ra và đã bị khoá."
      redirect_to match_path(@game) and return
    end
  end

  def calculate_money_for_match game
    money_statistic = {
      previous_match: 0,
      this_match: 0,
      company_contribute: 0,
      for_final: 0
    }
    money_statistic[:previous_match] = if game.first_match?
      0
    else
      Investment.find_by(game_id: game.previous_game.id).try(:remaining) || 0
    end
    money_statistic[:for_final] = game.final_match? ? Investment.sum(:remaining) : 0
    money_statistic[:this_match] = game.bets.sum(:total_money_bet)
    if money_statistic[:this_match].to_i > 0
      money_statistic[:company_contribute] = 3*game.round.money_rate
    end
    money_statistic
  end
end
