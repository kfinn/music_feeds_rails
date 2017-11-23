# frozen_string_literal: true

class PopgunPresentsFeed
  delegate :recommendations, to: :popgun_twitter_feed

  def popgun_twitter_feed
    @popgun_twitter_feed ||= PopgunTwitterFeed.new(
      screen_name: 'popgunpresents',
      artist_delimiter: '◥◣',
      recommendation_feed_id: :popgun_presents
    )
  end
end
