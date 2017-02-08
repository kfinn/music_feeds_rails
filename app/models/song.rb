require 'rspotify'

class Song < ApplicationRecord
  TITLE_REGEX = /^[“"]([^”"]+)[”"](.*)$/

  has_many :recommendations

  validates :artist, :title, null: false

  scope :ordered, -> { joins(:recommendations).group('songs.id').order('max(recommendations.recommended_at) desc') }

  def spotify_id
    spotify_track.try(:id)
  end

  def spotify_track
    @spotify_track ||= RSpotify::Track.search(search_query).first
  end

  def search_query
    "artist:\"#{artist}\" track:\"#{title_text}\""
  end

  def title_text
    TITLE_REGEX.match(title)[1]
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
