class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  def send_password_to_staff user, password
    @user = user
    @password = password
    @url = "http://localhost:3000/login"
    mail(to: @user.email, subject: "[NUS Event - Euro 2016] Password Information")
  end
end
