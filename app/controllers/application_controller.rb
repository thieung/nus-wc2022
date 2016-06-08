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

  protected

  def configure_permitted_parameters
    added_attrs = [:full_name, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
