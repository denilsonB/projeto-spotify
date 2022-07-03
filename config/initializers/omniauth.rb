require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "41a63d58c2604a8585e49523121b02e3", "b1c5a86e92d74fd58a9c7b5ae9d8bef1", scope: 'user-read-email playlist-modify-public playlist-modify-private user-library-read user-library-modify user-read-recently-played playlist-read-private playlist-read-collaborative'
end

OmniAuth.config.allowed_request_methods = [:post, :get, :put, :delete]