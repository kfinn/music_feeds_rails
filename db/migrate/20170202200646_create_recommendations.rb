# frozen_string_literal: true

class CreateRecommendations < ActiveRecord::Migration[5.0]
  def change
    create_table :recommendations do |t|
      t.string :guid, null: false
      t.string :url, null: false
      t.string :creator, null: false
      t.string :description
      t.references :song, foreign_key: true
      t.datetime :recommended_at, null: false

      t.timestamps
    end
  end
end
