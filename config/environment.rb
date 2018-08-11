# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Seedpod::Application.initialize!
ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
   :address => "smtp.gmail.com",
   :port => 587,
   :domain => "uofm-seedpod.herokuapp.com",
   :authentication => :plain,
   :user_name => "thammuchowdary@gmail.com",
   :password => "gretoefl123",
   :enable_starttls_auto => true
}
