class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :calculate_money_for_final_match
  before_action :configure_permitted_parameters, if: :devise_controller?

  def calculate_money_for_final_match
    @total_money_for_final = Investment.all.map(&:remaining).sum
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:full_name, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
