# frozen_string_literal: true

class SyncAllPlaylistsJob < ApplicationJob
  queue_as :default

  def perform
    Playlist.all.each do |playlist|
      playlist.delay.sync_to_spotify!
    end
  end
end
