# frozen_string_literal: true

class CreateSpotifyIdCorrections < ActiveRecord::Migration[5.0]
  def change
    create_table :spotify_id_corrections do |t|
      t.references :user, foreign_key: true
      t.references :song, foreign_key: true
      t.string :spotify_id

      t.timestamps
    end
  end
end
