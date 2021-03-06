# frozen_string_literal: true

class CreatePlaylists < ActiveRecord::Migration[5.0]
  def change
    create_table :playlists do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true
      t.string :spotify_id, null: false

      t.timestamps
    end
  end
end
