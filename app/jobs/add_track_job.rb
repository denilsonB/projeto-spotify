class AddTrackJob < ApplicationJob
  queue_as :default

  def perform(current_user,track_id,playlist_id)

    spotify_user = RSpotify::User.new(current_user.user_hash) 
    
    track = RSpotify::Track.find(track_id)
    
    app_playlist = Playlist.find(playlist_id)
    spotify_playlist = RSpotify::Playlist.find_by_id(app_playlist.id_spotify)
    
    begin 
      spotify_playlist.add_tracks!([track])
    rescue RestClient::BadRequest 
      redirect_to '/auth/spotify'
    end

  end
end
