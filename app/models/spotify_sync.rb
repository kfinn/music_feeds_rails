# frozen_string_literal: true

class SpotifySync < ApplicationRecord
  belongs_to :playlist

  after_create :eventually_sync!

  scope :recently_completed, -> { completed.order(completed_at: :desc) }
  scope :completed, -> { where.not(completed_at: nil) }

  def completed?
    completed_at.present?
  end

  def eventually_sync!
    delay.sync!
  end

  def sync!
    transaction do
      playlist.sync_to_spotify!
      update! completed_at: Time.zone.now
    end
  end
end
