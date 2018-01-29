# frozen_string_literal: true

class PopgunFeedRecommendation
  include ActiveModel::Model
  attr_accessor :artist, :tweet, :feed_id

  def guid
    "#{tweet.id}-#{artist}"
  end

  def song_query
    {
      artist: artist,
      title: song_query_title,
      spotify_id: top_spotify_track.id
    }
  end

  def known_song?
    top_music_feeds_song.present? || top_spotify_track.present?
  end

  def song_query_title
    if top_music_feeds_song
      top_music_feeds_song.title
    else
      top_spotify_track&.name
    end
  end

  def top_music_feeds_song
    unless instance_variable_defined?(:@top_music_feeds_song)
      @top_music_feeds_song = Song.where('lower(artist) = lower(:artist)', artist: artist).ordered.first
    end
    @top_music_feeds_song
  end

  def top_spotify_track
    unless instance_variable_defined?(:@top_spotify_track)
      @top_spotify_track = RSpotify::Track.search(search_query).first
    end
    @top_spotify_track
  end

  def search_query
    "artist:\"#{artist}\""
  end

  def to_recommendation_attributes
    {
      url: url,
      creator: creator,
      description: description,
      recommended_at: recommended_at,
      feed_id: feed_id
    }
  end

  def url
    tweet.urls.first.uri.to_s
  end

  def creator
    "#{tweet.user.name} (#{tweet.user.screen_name})"
  end

  def description
    tweet.full_text
  end

  def recommended_at
    tweet.created_at
  end
end
