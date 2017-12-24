# frozen_string_literal: true

class AddSpotifyIdUpdatedAtToSongs < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :spotify_id_updated_at, :datetime, index: true
  end
end
