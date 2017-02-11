require 'rspotify'

class Playlist < ApplicationRecord
  belongs_to :user

  validates :name, null: false

  before_save :sync_to_spotify!

  def sync_to_spotify!
    return if spotify_id
    self.spotify_id = RSpotify::User.new(user.to_rspotify_params).create_playlist!(name).id
  end

  def spotify_playlist
  end
end
