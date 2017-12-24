# frozen_string_literal: true

class SpotifyIdCorrection
  include ActiveModel::Model

  attr_accessor :song, :spotify_id

  def alternative_song_results
    @alternative_song_results ||= song.spotify_search_results
  end

  def save
    song.update spotify_id: spotify_id
  end
end
