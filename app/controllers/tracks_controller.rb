class TracksController < ApplicationController
    #GET /tracks
    def index 
        @tracks = Track.all()
    end

    #GET /tracks/show/{q}
    def show
        @tracks = RSpotify::Track.search(params[:q], limit: 10)
    end

    #GET /track/new?{id}
    def new
        @track = Track.new
    end
end
