class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  http_basic_authenticate_with name: 'nus', password: '45tgbhu89' if Rails.env.production?

  before_action :calculate_money_for_final_match
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :store_location

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "Bạn không có quyền truy cập vào trang này."
  end

  def store_location
    return unless request.get?
    if (request.path != "/login" &&
        request.path != "/profile/sign_in" &&
        request.path != "/profile/sign_up" &&
        request.path != "/profile/password/new" &&
        request.path != "/profile/password/edit" &&
        request.path != "/profile/confirmation" &&
        request.path != "/profile/sign_out" &&
        !request.xhr?)
      session[:previous_url] = request.fullpath
    end
  end

  def calculate_money_for_final_match
    @total_money_for_final = Investment.all.map(&:remaining).sum
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_update_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end

  def finish_group_stage?
    Game.finish_group_stage?
  end

  def finish_round_of_16?
    Game.finish_round_of_16?
  end

  def finish_quarter_final?
    Game.finish_quarter_final?
  end

  def finish_tournament?
    Game.finish_tournament?
  end

  helper_method :finish_group_stage?, :finish_round_of_16?, :finish_quarter_final?, :finish_tournament?

  def can_predict_before_group_stage?
    return false if !current_user || Game.started?
    DateTime.current <= DateTime.parse(Settings.predict_champion_deadline.first)
  end

  def can_predict_before_round_of_16?
    return false unless current_user
    finish_group_stage? && DateTime.current <= DateTime.parse(Settings.predict_champion_deadline.second)
  end

  def can_predict_before_quarter_final?
    return false unless current_user
    finish_round_of_16? && DateTime.current <= DateTime.parse(Settings.predict_champion_deadline.third)
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:nickname, :is_listen_music, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
