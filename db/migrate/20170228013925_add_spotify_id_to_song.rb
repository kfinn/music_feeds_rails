# frozen_string_literal: true

class AddSpotifyIdToSong < ActiveRecord::Migration[5.0]
  def change
    change_table :songs do |t|
      t.string :spotify_id
    end
  end
end
