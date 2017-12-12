class SpotifyIdCorrection < ApplicationRecord
  belongs_to :user
  belongs_to :song

  def alternative_song_results
    @alternative_song_results ||= song.spotify_search_results
  end
end
