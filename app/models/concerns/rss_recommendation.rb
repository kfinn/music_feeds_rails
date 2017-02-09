module RssRecommendation
  extend ActiveSupport::Concern

  included do
      attr_reader :rss
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
end
