class TracksController < ApplicationController
    include Pagy::Backend

    #GET /tracks
    def index 
        @pagy, @tracks = pagy(Track.all())
    end

    #GET /tracks/show/{q}
    def show
        @tracks = RSpotify::Track.search(params[:q], limit: 10)
    end

    #GET /track/new?{id}
    def new
        @track = Track.new
    end

    #POST /tracks
    def create
        
        track = RSpotify::Track.find(track_params[:track_id])
        
        if Playlist.find_by(id: track_params[:playlist_id]).tracks.where(id_spotify: track.id).exists?
            return redirect_to tracks_path
        else
            AddTrackJob.perform_now(current_user,track_params[:track_id],track_params[:playlist_id])
        end

        @service = TrackServices::Create.call(track,track_params[:playlist_id])

        redirect_to tracks_path if @service.success?

    end
    
    # DELETE /tracks/{id}
    def destroy
        @track = Track.find(params[:id])
        spotify_track = RSpotify::Track.find(@track.id_spotify)
        spotify_playlist = RSpotify::Playlist.find_by_id(@track.playlist.id_spotify)

        if @track.status == "on_queue"
            spotify_playlist.remove_tracks!([spotify_track])
        end

        @track.destroy
        redirect_to tracks_path

    end 

    private 

    def track_params
        params.require(:track).permit(:track_id, :playlist_id)
    end
end
