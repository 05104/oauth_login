Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = %i[post get]
  
  provider :google_oauth2, Rails.application.credentials.dig(:omniauth, :google, :key), 
  Rails.application.credentials.dig(:omniauth, :google, :secret), scope: 'email,profile'
end