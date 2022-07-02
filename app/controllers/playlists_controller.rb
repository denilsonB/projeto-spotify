class PlaylistsController < ApplicationController
    before_action :authenticate_user!
    
    # GET /playlists
    def index
        @playlists = current_user.playlists
    end

    # GET /playlists/{id}
    def show 
        @playlist = Playlist.find(params[:id])
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
        #fazer depois de criar as tracks
    end

    private
    
    def render_service
        if @service.success?
            redirect_to playlists_path
        else
            redirect_to '/auth/spotify'
        end
    end

    def playlist_params
        params.require(:playlist).permit(:name)
    end
end
