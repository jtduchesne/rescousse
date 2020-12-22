Rails.application.config.middleware.use OmniAuth::Builder do
  unless Rails.env.production?
    credentials = Rails.application.credentials.facebook[:test]
  else
    credentials = Rails.application.credentials.facebook
  end
  
  provider :facebook, credentials[:app_id], credentials[:app_secret],
                      scope: 'public_profile,email', origin_param: false
  
  configure do |config|
    config.failure_raise_out_environments = []
    config.logger = Rails.logger
  end
end
