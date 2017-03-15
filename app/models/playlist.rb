require 'rspotify'

class Playlist < ApplicationRecord
  belongs_to :user
  has_many :spotify_syncs

  validates :name, null: false

  before_create :create_spotify_playlist!

  delegate :rspotify_user, to: :user

  def sync_to_spotify!
    spotify_playlist.replace_tracks! Song.interesting.ordered.first(50).map(&:spotify_track).compact unless fresh?
  end

  def spotify_playlist
    @spotify_playlist ||= RSpotify::Playlist.find(rspotify_user.id, spotify_id)
  end

  def create_spotify_playlist!
    self.spotify_id = rspotify_user.create_playlist!(name).id
    sync_to_spotify!
  end

  def fresh?
    spotify_syncs.recently_completed.first.completed_at > FeedUpdate.recently_completed.first.completed_at
  end
end
