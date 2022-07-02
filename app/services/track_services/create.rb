module TrackServices
    class Create  < ApplicationService
        prepend SimpleCommand

        def initialize(track,playlist_id)
            @name = track.name
            @href = track.href
            @id_spotify = track.id
            @time = track.duration_ms
            @playlist_id = playlist_id
        end

        def call 
            create_track
        end
        
        private 

        def create_track
            track = Track.new(
                name: @name,
                href: @href,
                id_spotify: @id_spotify,
                time: @time,
                playlist_id: @playlist_id
            )

            if !track.save
                errors.add(:track_erros,track.errors)
            else
                track
            end
        end
    end
end