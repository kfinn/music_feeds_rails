require 'rspotify'

class Song < ApplicationRecord
  has_many :recommendations

  validates :artist, :title, null: false

  scope :ordered, -> { joins(:recommendations).group('songs.id').order('max(recommendations.recommended_at) desc') }
  scope :interesting, -> { joins(:recommendations).merge(Recommendation.interesting) }

  before_save :hydrate_spotify_id!

  def spotify_track
    hydrate_spotify_id!
    spotify_id_track || spotify_search_track
  end

  def hydrate_spotify_id!
    return if spotify_id.present?
    self.spotify_id = spotify_search_track.id if spotify_search_track.present?
  end

  def spotify_id_track
    unless instance_variable_defined?(:@spotify_id_track)
      @spotify_id_track = spotify_id.present? ? RSpotify::Track.find(spotify_id) : nil
    end
    @spotify_id_track
  end

  def spotify_search_track
    unless instance_variable_defined?(:@spotify_search_track)
      @spotify_search_track = RSpotify::Track.search(search_query).first
    end
    @spotify_search_track
  end

  def search_query
    "artist:\"#{artist}\" track:\"#{title}\""
  end

  def as_json(*)
    {
      id: id,
      artist: artist,
      title: title,
      spotify_id: spotify_id,
      key: key,
      recommendations: recommendations.as_json
    }
  end
end
