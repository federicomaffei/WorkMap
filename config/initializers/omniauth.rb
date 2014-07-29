Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.omniauth_google_client_id, Rails.application.secrets.omniauth_google_client_secret
end

