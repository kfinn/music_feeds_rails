require 'nokogiri'
require 'open-uri'

class PitchforkBestNewTrack
  include RssRecommendation

  attr_reader :rss

  def initialize(rss)
    @rss = rss
  end

  def song_artist
    TITLE_PATTERN.match(og_title)[2]
  end

  def song_title
    TITLE_PATTERN.match(og_title)[1]
  end

  TITLE_PATTERN = /^Listen to â\u0080\u009C(.+)â\u0080\u009D.* by ([^\)]+)$/

  def og_title
    html.css('meta[name="og:title"]').attribute('content').text
  end

  def html
    @html ||= Nokogiri::HTML open url
  end
end
