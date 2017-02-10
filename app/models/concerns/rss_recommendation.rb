module RssRecommendation
  extend ActiveSupport::Concern

  module ClassMethods
    def feed_id(feed_id = nil)
      @feed_id ||= feed_id
    end
  end

  included do
    attr_reader :rss
    delegate :feed_id, to: :class
  end

  def guid
    rss.guid.content
  end

  def url
    rss.link
  end

  def creator
    rss.dc_creator
  end

  def description
    rss.description
  end

  def recommended_at
    rss.pubDate
  end

  def song_query
    { title: song_title, artist: song_artist }
  end

  def to_recommendation_attributes
    {
      url: url,
      creator: creator,
      description: description,
      recommended_at: recommended_at,
      feed_id: feed_id
    }
  end
end
