class CreateFeedUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :feed_updates do |t|
      t.string :feed_id, index: true
      t.datetime :completed_at, index: true

      t.timestamps
    end
  end
end
