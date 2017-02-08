require 'rss'
require 'open-uri'

class StereogumFeed
  def recommendations
    feed_items.select &:song?
  end

  def rss
    @rss ||= RSS::Parser.parse(open('http://www.stereogum.com/music/feed/'))
  end

  private

  def feed_items
    @feed_items ||= rss.items.map { |item| StereogumRecommendation.new item }
  end
end
