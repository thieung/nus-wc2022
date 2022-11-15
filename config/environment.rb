# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :port           => 465,
  :address        => ENV['SMTP_HOST'],
  :user_name      => ENV['SMTP_USERNAME'],
  :password       => ENV['SMTP_PASSWORD'],
  :domain         => ENV['SMTP_DOMAIN'],
  :authentication => :plain,
  :ssl            => true
}
ActionMailer::Base.delivery_method = :smtp
