# frozen_string_literal: true

class CreateSongOpinions < ActiveRecord::Migration[5.0]
  def change
    create_table :song_opinions do |t|
      t.references :user, foreign_key: true
      t.references :song, foreign_key: true
      t.boolean :interesting

      t.timestamps
    end
  end
end
