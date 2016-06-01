class HomeController < ApplicationController
  def index
    today = Date.today
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
      @all_matches = Game.ordered
    end
  end
end
