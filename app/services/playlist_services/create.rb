module PlaylistServices
    class Create  < ApplicationService
        prepend SimpleCommand

        def initialize(current_user,playlist_params)
            @current_user = current_user
            @name = playlist_params[:name]
        end

        def call 
            create_playlist
        end
        
        private 

        def create_playlist
            spotify_user = RSpotify::User.new(@current_user.user_hash)

            spotify_playlist = spotify_user.create_playlist!(@name,public: false, collaborative: true)
    
            playlist = @current_user.playlists.build(
                name: @name,
                image_url: spotify_playlist.images,
                public: spotify_playlist.public,
                owner: spotify_playlist.owner.to_hash,
                href: spotify_playlist.href,
                uri: spotify_playlist.uri,
                path: spotify_playlist.path,
                id_spotify: spotify_playlist.id
            )

            if !playlist.save
                errors.add(:playlist_error,playlist.errors)
            else
                playlist
            end
        end
    end
end