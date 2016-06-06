class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:pick_champion]
  def statistics

  end

  def predict_champion
  end

  def pick_champion
    redirect_to predict_champion_path
  end
end
