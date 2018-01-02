# frozen_string_literal: true

require 'rspotify'

class Playlist < ApplicationRecord
  belongs_to :user
  has_many :spotify_syncs

  validates :name, null: false

  before_create :create_spotify_playlist!

  delegate :rspotify_user, to: :user

  def sync_to_spotify!
    return if fresh?
    spotify_playlist.replace_tracks!(
      Song
      .interesting_to_user(user)
      .ordered
      .first(50)
      .map(&:spotify_track)
      .compact
    )
  end

  def spotify_playlist
    @spotify_playlist ||= RSpotify::Playlist.find(rspotify_user.id, spotify_id)
  end

  def create_spotify_playlist!
    self.spotify_id = rspotify_user.create_playlist!(name).id
    sync_to_spotify!
  end

  def fresh?
    fresher_than_syncs? && fresher_than_opinions?
  end

  def fresher_than_syncs?
    return false if spotify_syncs.recently_completed.empty?
    return true if FeedUpdate.recently_completed.empty?

    spotify_syncs.recently_completed.first.completed_at > FeedUpdate.recently_completed.first.completed_at
  end

  def fresher_than_opinions?
    return false if spotify_syncs.recently_completed.empty?
    return true if user.song_opinions.empty?

    spotify_syncs.recently_completed.first.completed_at > user.song_opinions.maximum(:updated_at)
  end
end
