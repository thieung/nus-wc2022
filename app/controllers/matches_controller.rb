class MatchesController < ApplicationController
  before_action :load_match, only: [:show, :check_valid_match, :predict_score, :predict_score_edit_view, :update_betting_scores, :update_match_score, :import_user_betting_scores, :import_number_users, :update_score, :future_match_update_info, :random_score, :send_report_email_to_all_staffs]
  before_action :check_valid_match, only: [:show, :update_betting_scores, :update_match_score, :import_user_betting_scores, :import_number_users, :update_score, :random_score, :send_report_email_to_all_staffs]
  before_action :authenticate_user!, only: [:predict_score, :predict_score_edit_view, :update_betting_scores, :update_match_score, :import_user_betting_scores, :import_number_users, :update_score, :future_match_update_info, :random_score, :send_report_email_to_all_staffs]

  def index
    today   = DateTime.current
    @groups = Group.all.index_by(&:id)
    @rounds = Round.all.index_by(&:id)
    @teams  = Team.all.index_by(&:id)
    @type = params[:type]||'all_matches'
    @games = Game.send(@type)

    if params[:type].blank?
      if today <= Date.parse(Settings.group_stage.end)
        redirect_to matches_path({type: 'group_stage'}) and return
      elsif today <= Date.parse(Settings.round_of_16.end)
        redirect_to matches_path({type: 'round_of_16'}) and return
      elsif today <= Date.parse(Settings.quarter_final.end)
        redirect_to matches_path({type: 'quarter_final'}) and return
      elsif today <= Date.parse(Settings.semi_final.end)
        redirect_to matches_path({type: 'semi_final'}) and return
      # elsif today.to_date <= Date.parse(Settings.third_fourth.end)
      #   redirect_to matches_path({type: 'third_fourth'}) and return
      else
        redirect_to matches_path({type: 'final'}) and return
      end
    end
    @upcoming_matches = @games.not_locked.select("games.*, date(play_at) as occur_date").order("occur_date").group_by(&:occur_date)
    tmp_past_matches = @games.locked.select("games.*, date(play_at) as occur_date").order("occur_date")
    @past_matches = tmp_past_matches.group_by(&:occur_date)
    @recent_matches = tmp_past_matches.order("pos").last(MAX_RECENT_MATCHES).group_by(&:occur_date)
  end

  def show
    @money_statistic = calculate_money_for_match @game
    @sponsor_detail = Settings.sponsor_contribute.find_all { |item| item['game_id'] == @game.id }

    if @game.has_score?
      @winners = @game.list_winners
    end
  end

  def predict_score
    return unless @game.available_to_bet
    return unless current_user.can_bet_on_match?(@game)
    score_ids = if params[:match].blank? || params[:match][:score_ids].blank?
      []
    else
      params[:match][:score_ids]
    end

    bet_info = current_user.get_bet_info_on_match(params[:id]) || current_user.bets.new(game_id: @game.id)
    bet_info.score_ids = bet_info.score_ids | score_ids
    bet_info.last_changed_at = DateTime.current
    bet_info.total_money_bet = bet_info.score_ids.size * @game.round.money_rate
    unless bet_info.save
      @err_msg = bet_info.errors.full_messages.first
    else
      # Mailer.process_notice_bet_result_to_staffs(bet_info) unless Settings.is_turn_off_mail
      @money_statistic = calculate_money_for_match @game
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

  def send_report_email_to_all_staffs
    authorize! :manage, current_user
    Mailer.process_notice_all_bets_info_to_staffs(@game) unless Settings.is_turn_off_mail
    @game.update_attributes(is_reported: true)
    redirect_to match_path(@game)
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
    if !Settings.is_demo && DateTime.current < (@game.play_at + 90.minutes)
      @err_msg = "Trận đấu chưa kết thúc, bạn chưa thể cập nhật tỉ số trận đấu này."
    elsif !current_user.can_update_result_on_match?(@game.id)
      @err_msg = "Trận đấu trước chưa được xử lý xong, bạn chưa thể cập nhật tỉ số trận đấu này."
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
          # Draw
          !params[:result_winner_id].blank? ? params[:result_winner_id].to_i : nil
        end
        success = @game.update_attributes(
          score1: score_team1,
          score2: score_team2,
          score_id: score.id,
          locked: true,
          winner: winner_team_id,
          reason: score_team1 == score_team2 ? params[:reason] : nil
        )
        unless success
          @err_msg = "Không thể cập nhật kết quả trận đấu, vui lòng kiểm tra lại."
        else
          Mailer.process_notice_match_result_to_staffs(@game) unless Settings.is_turn_off_mail

          # Send top scores report
          case Game.locked.size
          when Settings.top_scores_report_match_id.first_round_group_stage.to_i
            Mailer.process_staffs_top_scores_report_after_first_round_group_stage unless Settings.is_turn_off_mail
          when Settings.top_scores_report_match_id.second_round_group_stage.to_i
            Mailer.process_staffs_top_scores_report_after_second_round_group_stage unless Settings.is_turn_off_mail
          when Settings.top_scores_report_match_id.third_round_group_stage.to_i
            Mailer.process_staffs_top_scores_report_after_third_round_group_stage unless Settings.is_turn_off_mail
          when Settings.top_scores_report_match_id.round_of_16.to_i
            Mailer.process_staffs_top_scores_report_after_round_of_16 unless Settings.is_turn_off_mail
          when Settings.top_scores_report_match_id.quarter_final.to_i
            Mailer.process_staffs_top_scores_report_after_quarter_final unless Settings.is_turn_off_mail
          when Settings.top_scores_report_match_id.semi_final.to_i
            Mailer.process_staffs_top_scores_report_after_semi_final unless Settings.is_turn_off_mail
          # when Settings.top_scores_report_match_id.third_fourth.to_i
          #   Mailer.process_staffs_top_scores_report_after_third_fourth unless Settings.is_turn_off_mail
          when Settings.top_scores_report_match_id.final.to_i
            Mailer.process_staffs_top_scores_report_after_final unless Settings.is_turn_off_mail
          end
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

  def random_score
    @err_msq = ''
    total_matches = params[:random_total_scores].to_i
    if total_matches < 1 || total_matches > 3
      @err_msg = 'Có lỗi xảy ra, bạn chỉ có thể dự đoán tối đa 3 tỉ số hoặc tối thiểu 1 tỉ số'
    else
      conditions = ['']
      if params[:random_winner_id].to_i == @game.team1_id
        if params[:random_can_draw].present?
          conditions[0] += "score1 >= score2"
        else
          conditions[0] += "score1 > score2"
        end
        conditions[0] += " AND score1 <= ?"
        conditions << params[:random_max_number].to_i
      else
        if params[:random_can_draw].present?
          conditions[0] += "score1 <= score2"
        else
          conditions[0] += "score1 < score2"
        end
        conditions[0] += " AND score2 <= ?"
        conditions << params[:random_max_number].to_i
      end
      random_scores = Score.where(conditions).order("RANDOM()").limit(params[:random_total_scores].to_i)
      @random_score_ids = random_scores.map(&:id).uniq
      @random_score_content = random_scores.map(&:name).join(', ')
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
      for_final: 0,
      boss_contribute: 0,
      sponsor_contribute: 0
    }
    money_statistic[:previous_match] = if game.first_match?
      0
    else
      Investment.find_by(game_id: game.previous.id).try(:remaining) || 0
    end
    money_statistic[:for_final] = game.final_match? ? Investment.sum(:remaining) : 0
    money_statistic[:this_match] = game.bets.sum(:total_money_bet)
    if money_statistic[:this_match].to_i > 0
      money_statistic[:company_contribute] = 3*game.round.money_rate
    end
    money_statistic[:boss_contribute] = Settings.boss_contribute.find { |item| item['game_id'] == game.id }&.send(:[], 'money') || 0
    money_statistic[:sponsor_contribute] = Settings.sponsor_contribute.find_all { |item| item['game_id'] == @game.id }&.map(&:money).sum || 0
    money_statistic
  end
end
