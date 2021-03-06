# frozen_string_literal: true

require 'rspotify'

class Song < ApplicationRecord
  has_many :recommendations
  has_many :song_opinions

  validates :artist, :title, null: false

  scope :interesting, -> { where id: Recommendation.interesting.select(:song_id) }

  def self.interesting_to_user(user)
    interesting.where.not id: user.song_opinions.boring.select(:song_id)
  end

  before_save :reset_spotify_id!, if: :spotify_id_conflicts?

  def self.ordered
    order(<<~SQL.squish)
      COALESCE("spotify_id_updated_at" :: DATE, '2017-01-01') DESC
    SQL
      .order <<~SQL.squish
        (
          SELECT MAX("recommendations"."recommended_at")
          FROM "recommendations"
          WHERE "recommendations"."song_id" = "songs"."id"
        ) DESC
      SQL
  end

  def spotify_id(hydrate: true)
    return super() if super().present? || !hydrate
    hydrate_spotify_id!
    super()
  end

  def spotify_id=(spotify_id)
    super
    self.spotify_id_updated_at = spotify_id.present? ? Time.zone.now : nil
  end

  def spotify_track
    spotify_id_track || spotify_search_track
  end

  def hydrate_spotify_id!
    return if @hydration_attempted
    @hydration_attempted = true
    spotify_search_track.try(:id).tap do |spotify_id|
      update!(spotify_id: spotify_id) if spotify_id.present?
    end
  end

  def spotify_id_track
    unless instance_variable_defined?(:@spotify_id_track)
      @spotify_id_track = spotify_id.present? ? RSpotify::Track.find(spotify_id) : nil
    end
    @spotify_id_track
  end

  def spotify_search_track
    unless instance_variable_defined?(:@spotify_search_track)
      @spotify_search_track = spotify_search_results.first
    end
    @spotify_search_track
  end

  def spotify_search_results
    @spotify_search_results ||= RSpotify::Track.search(search_query)
  end

  def self.from_spotify_track(spotify_track)
    new(
      artist: spotify_track.artists.first.name,
      title: spotify_track.name,
      spotify_id: spotify_track.id
    )
  end

  def search_query
    {
      artist: artist,
      track: title
    }.compact.map { |k, v| "#{k}:\"#{v}\"" }.join ' '
  end

  def build_spotify_id_correction(attributes)
    SpotifyIdCorrection.new(attributes.merge(song: self))
  end

  def reset_spotify_id!
    update! spotify_id: nil
  end

  def spotify_id_conflicts?
    return false unless spotify_id(hydrate: false).present?
    spotify_search_results.map(&:id).exclude? spotify_id
  end
end
