# frozen_string_literal: true

class CreateSpotifySyncs < ActiveRecord::Migration[5.0]
  def change
    create_table :spotify_syncs do |t|
      t.references :playlist, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
