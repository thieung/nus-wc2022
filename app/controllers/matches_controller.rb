class MatchesController < ApplicationController
  before_action :check_valid_match, only: :show

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
        redirect_to round_of_16_matches_path and return
      elsif Date.parse(Settings.quarter_final.start) <= today && today >= Date.parse(Settings.quarter_final.end)
        redirect_to quarter_final_matches_path and return
      elsif Date.parse(Settings.semi_final.start) <= today && today >= Date.parse(Settings.semi_final.end)
        redirect_to semi_final_matches_path and return
      elsif Date.parse(Settings.final.start) <= today && today >= Date.parse(Settings.final.end)
        redirect_to final_matches_path and return
      end
    end
    @all_matches = @games.select("games.*, date(play_at) as occur_date").group_by(&:occur_date)
  end

  def show

  end

  def check_valid_match
    @game = Game.find_by id: params[:id]
    unless @game.can_bet?
      redirect_to root_path and return
    end
  end
end
