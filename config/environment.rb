# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Bgwebmon::Application.initialize!

ActionMailer::Base.smtp_settings = {
   :address         => 'smtp.yandex.ru',
   :port            => 465,
   :domain          => 'ruby.crimeainfo.com',
   :user_name 			=> 'ruby@crimeainfo.com',
   :password 				=> ENV["YANDEX_PASSWORD"],
   :authentication  => :plain,
   :ssl             => true

} 
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.perform_deliveries = true
