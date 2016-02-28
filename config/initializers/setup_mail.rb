if Rails.env.development? || Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:        'smtp.sendgrid.net',
    port:           '2525',
    authentication: :plain,
    user_name:      ENV['SENDGRID_USERNAME'],
    password:       ENV['SENDGRID_PASSWORD'],
    domain:         'heroku.com',
    enable_starttls_auto: true
  }
end

#The code in config/initialize runs when our app starts. We use this when want to set config options or application settings.
#In this case we need to configure some special settings to send emails.

#Notice that we didn't explicitly state the SendGrid username and password.
#We want to mask these for security concerns, so we assign them to environment variables.
#Environment variables provide a reference point to information, without revealing the underlying data values.
#use the Figaro gem to set up environment variables

#Sensitive data, like API keys and passwords, should not be stored in GitHub.
