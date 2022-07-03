class PlaylistsController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_spotify
    
    # GET /playlists
    def index
        @playlists = Playlist.all()
    end

    # GET /playlists/{id}
    def show 
        @playlist = Playlist.find(params[:id])
        RemoveTrackJob.set(wait: 210.seconds).perform_later(@playlist.user.id,@playlist.id)

        @playlist
    end

    # GET /playlists/new
    def new 
        @playlist = Playlist.new
    end

    # POST /playlists
    def create
        @service = PlaylistServices::Create.call(current_user,playlist_params)

        render_service
    end

    # GET /playlists/{id}/edit
    def edit 
        @playlist = Playlist.find(params[:id])
    end 

    # PUT /playlists/{id}
    def update
        @service = PlaylistServices::Update.call(params[:id],playlist_params)

        render_service
    end

    #DELETE /playlists/{id}
    def destroy
        @playlist = Playlist.find(params[:id])
        spotify_playlist = RSpotify::Playlist.find_by_id(@playlist.id_spotify)

        spotify_playlist.remove_tracks!(spotify_playlist.tracks)

        if @playlist.destroy
            redirect_to playlists_path
        end
    end

    private
    
    def render_service
        if @service.success?
            RemoveTrackJob.set(wait: 210.seconds).perform_later(@playlist.user.id,@playlist.id)
            redirect_to playlists_path
        else
            redirect_to '/auth/spotify'
        end
    end

    def playlist_params
        params.require(:playlist).permit(:name)
    end
end
