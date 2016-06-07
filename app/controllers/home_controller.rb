class HomeController < ApplicationController
  before_action :authenticate_user!, only: :management

  def index
    today   = Date.today
    @groups  = Group.all.index_by(&:id)
    @rounds = Round.all.index_by(&:id)
    @teams  = Team.all.index_by(&:id)
    if Date.parse(Settings.group_stage.start) <= today && today >= Date.parse(Settings.group_stage.end)
      redirect_to group_stage_matches_path and return
    elsif Date.parse(Settings.round_of_16.start) <= today && today >= Date.parse(Settings.round_of_16.end)
      redirect_to round_of_16_matches_path and return
    elsif Date.parse(Settings.quarter_final.start) <= today && today >= Date.parse(Settings.quarter_final.end)
      redirect_to quarter_final_matches_path and return
    elsif Date.parse(Settings.semi_final.start) <= today && today >= Date.parse(Settings.semi_final.end)
      redirect_to semi_final_matches_path and return
    elsif Date.parse(Settings.final.start) <= today && today >= Date.parse(Settings.final.end)
      redirect_to final_matches_path and return
    else
      @all_matches = Game.select("games.*, date(play_at) as occur_date").group_by(&:occur_date)
    end
  end

  def predict_champion
  end

  def management
    authorize! :manage, current_user
  end
end
