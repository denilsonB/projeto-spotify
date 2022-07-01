require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "41a63d58c2604a8585e49523121b02e3", "b1c5a86e92d74fd58a9c7b5ae9d8bef1", scope: 'user-follow-modify user-read-recently-played playlist-read-collaborative user-read-email playlist-modify-public user-library-modify user-follow-read user-read-currently-playing user-library-read playlist-read-private user-read-private playlist-modify-private '
end

OmniAuth.config.allowed_request_methods = [:post, :get, :put, :delete]