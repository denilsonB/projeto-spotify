class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        playlists_path
    end
    
    def authenticate_spotify
        if current_user.user_hash.empty?()
            redirect_to '/auth/spotify'
        end
    end
end
