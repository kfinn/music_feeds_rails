# frozen_string_literal: true

class IndexSpotifySyncsOnCompletedAt < ActiveRecord::Migration[5.0]
  def change
    add_index :spotify_syncs, :created_at
  end
end
