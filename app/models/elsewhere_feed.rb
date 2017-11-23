# frozen_string_literal: true

class ElsewhereFeed
  delegate :recommendations, to: :popgun_twitter_feed

  def popgun_twitter_feed
    @popgun_twitter_feed ||= PopgunTwitterFeed.new(
      screen_name: 'elsewherespace',
      artist_delimiter: '└',
      recommendation_feed_id: :elsewhere
    )
  end
end
