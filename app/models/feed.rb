require 'nokogiri'
require 'open-uri'

class Feed
  def feed_items
    @feed_items ||= xml_doc.css('item').map { |item| FeedItem.new item }
  end

  def xml_doc
    @xml_doc ||= Nokogiri::XML(open('http://www.stereogum.com/music/feed/'))
  end
end
