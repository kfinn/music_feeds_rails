require 'rspotify'

class Song < ApplicationRecord
  TITLE_REGEX = /^[“"]([^”"]+)[”"](.*)$/

  def spotify_id
    spotify_track.try(:id)
  end

  def spotify_track
    @spotify_track ||= RSpotify::Track.search(search_query).first
  end

  def search_query
    artist + ' ' + title_text
  end

  def title_text
    TITLE_REGEX.match(title)[1]
  end
end
