# frozen_string_literal: true

class FeedUpdate < ApplicationRecord
  after_create :eventually_update_feed!

  scope :recently_completed, -> { completed.order(completed_at: :desc) }
  scope :completed, -> { where.not(completed_at: nil) }

  def completed?
    completed_at.present?
  end

  def feed
    Feed.find feed_id
  end

  def eventually_update_feed!
    delay.update_feed!
  end

  def update_feed!
    transaction do
      feed.update_from_remote!
      Playlist.find_each { |p| p.spotify_syncs.create! }
      update! completed_at: Time.zone.now
    end
  end
end
