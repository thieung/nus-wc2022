class MatchesController < ApplicationController
  before_action :load_match, only: [:show, :check_valid_match, :predict_score, :predict_score_edit_view, :update_betting_scores, :update_match_score, :import_user_betting_scores, :import_number_users]
  before_action :check_valid_match, only: [:show, :update_betting_scores, :update_match_score, :import_user_betting_scores, :import_number_users]
  before_action :authenticate_user!, only: [:predict_score, :predict_score_edit_view, :update_betting_scores, :update_match_score, :import_user_betting_scores, :import_number_users]

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
    @all_matches = @games.select("games.*, date(play_at) as occur_date").group_by(&:occur_date)
  end

  def show
    @game = Game.find_by id: params[:id]
  end

  def predict_score
    return unless @game.available_to_bet
    # bet_info = current_user.get_bet_info_on_match params[:id]
    # if bet_info
    #   bet_info.update_attributes(match_params)
    # else
    #   bet_info = current_user.bets.new(match_params)
    #   bet_info.game_id = params[:id]
    #   bet_info.save
    # end
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
    redirect_to match_path(@game) and return
  end

  def import_number_users
    authorize! :manage, current_user
    @number = params[:number_user].to_i
  end

  def add_row
    authorize! :manage, current_user
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
end
