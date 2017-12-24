# frozen_string_literal: true

class SongOpinion < ApplicationRecord
  belongs_to :user
  belongs_to :song

  after_save -> { delay.eventually_sync_to_spotify }

  scope :boring, -> { where interesting: false }

  def eventually_sync_to_spotify
    user.playlists.each(&:create_spotify_sync!)
  end
end
