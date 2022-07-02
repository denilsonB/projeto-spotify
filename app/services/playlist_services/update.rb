module PlaylistServices
    class Update  < ApplicationService
        prepend SimpleCommand

        def initialize(id_playlist,playlist_params)
            @id = id_playlist
            @params = playlist_params
        end

        def call 
            update_playlist
        end
        
        private 

        def update_playlist
            playlist = Playlist.find(@id)

            spotify_playlist = RSpotify::Playlist.find_by_id(playlist.id_spotify)
    
            spotify_playlist.change_details!(name: @params[:name])

            if !playlist.update(@params)
                errors.add(:playlist_error,playlist.errors)
            else
                playlist
            end
        end
    end
end