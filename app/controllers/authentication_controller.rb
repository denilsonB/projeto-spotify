class AuthenticationController < ApplicationController
    before_action :authenticate_user!
    protect_from_forgery prepend: true

    def spotify
        @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        current_user.user_hash = @spotify_user.to_hash
        current_user.save
        
        render json: current_user.user_hash
        
    end 
end
