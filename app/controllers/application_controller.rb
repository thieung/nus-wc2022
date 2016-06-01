class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :calculate_money_for_final_match

  def calculate_money_for_final_match
    @total_money_for_final = Investment.all.map(&:remaining).sum
  end
end
