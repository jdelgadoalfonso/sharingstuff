# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sharingstuff::Application.initialize!

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "gmail.com",
  :authentication => "plain",
  :user_name => "jdelgadoalfonso@gmail.com",
  :password => "AR62DiUhNA31B0"
}

ActionMailer::Base.default :content_type => "text/html"