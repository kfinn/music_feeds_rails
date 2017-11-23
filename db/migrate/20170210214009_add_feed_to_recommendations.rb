# frozen_string_literal: true

class AddFeedToRecommendations < ActiveRecord::Migration[5.0]
  def change
    change_table :recommendations do |t|
      t.integer :feed_id, null: false, default: 0
    end
  end
end
