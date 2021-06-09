# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# ActionMailer::Base.smtp_settings = {
#   address: 'smtp.sendgrid.net',
#   port: 587,
#   domain: 'nus-euro2020.herokuapp.com',
#   user_name: ENV['SENDGRID_USERNAME'],
#   password: ENV['SENDGRID_PASSWORD'],
#   authentication: :login,
#   enable_starttls_auto: true
# }

ActionMailer::Base.smtp_settings = {
  :port           => '465',
  :address        => 'smtp.nustechnology.com',
  :user_name      => 'euro2020@nustechnology.com',
  :password       => 'n%Llkpb7kGJpGlV0',
  :domain         => 'nus-euro2020.herokuapp.com',
  :authentication => :plain
}
ActionMailer::Base.delivery_method = :smtp
