# frozen_string_literal: true

require 'rss'
require 'open-uri'

class PitchforkBestNewTracksFeed
  def recommendations
    @recommendations ||= rss.items.map { |item| PitchforkBestNewTrack.new item }
  end

  def rss
    @rss ||= RSS::Parser.parse open 'https://pitchfork.com/rss/reviews/best/tracks/'
  end
end
