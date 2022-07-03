class RemoveTrackJob < ApplicationJob
  queue_as :default

  def perform(user_id,playlist_id)
    user_app = User.find(user_id)
    playlist_app = Playlist.find(playlist_id)

    spotify_user = RSpotify::User.new(user_app.user_hash)

    #pega as musicas recetemente ouvidas pelo usuario e compara com as do banco
    latest_listened = spotify_user.recently_played
    ids_latest_listened = latest_listened.map(&:id)
    
    p ids_latest_listened

    tracks_of_playlist_app = playlist_app.tracks.where(id_spotify: ids_latest_listened, status: 0)
    


    tracks = RSpotify::Track.find(tracks_of_playlist_app.map(&:id_spotify))

    spotify_playlist = RSpotify::Playlist.find_by_id(playlist_app.id_spotify)
    spotify_playlist.remove_tracks!(tracks)

    tracks_of_playlist_app.map do |track|
      track.status = 1
      track.save
    end

    RemoveTrackJob.set(wait: 210.seconds).perform_later(user_id,playlist_id)

  end
end
