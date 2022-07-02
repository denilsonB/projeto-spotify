class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        playlists_path
    end
end
