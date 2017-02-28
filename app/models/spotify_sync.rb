class SpotifySync < ApplicationRecord
  belongs_to :playlist

  after_create :eventually_sync!

  def completed?
    completed_at.present?
  end

  def eventually_sync!
    delay.sync!
  end

  def sync!
    playlist.sync_to_spotify!
    update! completed_at: Time.zone.now
  end
end
