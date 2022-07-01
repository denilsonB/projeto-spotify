Rails.application.routes.draw do
  devise_for :users

  get '/auth/spotify/callback', to: 'authentication#spotify'
end
 