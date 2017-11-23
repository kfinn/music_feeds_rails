# frozen_string_literal: true

class Recommendation < ApplicationRecord
  belongs_to :song

  validates :guid, :url, :creator, null: false

  scope :interesting, -> { where.not('description like ?', '%metal%').where.not('description like ?', '%thrash%') }
  scope :ordered, -> { order recommended_at: :desc }

  enum feed_id: %i[stereogum pitchfork_best_new_track]

  def self.for_feed(feed)
    where feed_id: feed.id
  end

  def as_json(*)
    {
      id: id,
      guid: guid,
      url: url,
      creator: creator,
      description: description,
      recommended_at: recommended_at
    }
  end

  def feed
    @feed ||= Feed.find feed_id
  end
end
