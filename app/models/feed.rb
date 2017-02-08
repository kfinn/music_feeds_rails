require 'rss'
require 'open-uri'

class Feed
  def feed_items
    @feed_items ||= rss.items.map { |item| FeedItem.new item }
  end

  def rss
    @rss ||= RSS::Parser.parse(open('http://www.stereogum.com/music/feed/'))
  end
end
