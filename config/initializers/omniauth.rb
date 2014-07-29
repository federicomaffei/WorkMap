# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2, Rails.application.secrets.omniauth_google_client_id, Rails.application.secrets.omniauth_google_client_secret,
#   {
#       :name => "google",
#       :scope => "email, profile, plus.me, http://gdata.youtube.com",
#       :prompt => "select_account",
#       :image_aspect_ratio => "square",
#       :image_size => 50
#     }
# end

