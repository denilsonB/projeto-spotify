Rails.application.routes.draw do
  root to: 'authentication#spotify'

  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  resources :playlists
  resources :tracks

  get '/auth/spotify/callback', to: 'authentication#spotify'
end
 