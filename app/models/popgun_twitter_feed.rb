# frozen_string_literal: true

class PopgunTwitterFeed
  include ActiveModel::Model

  attr_accessor :screen_name, :artist_delimiter, :recommendation_feed_id
  delegate :tweets, to: :twitter_feed

  def recommendations
    @recommendations ||= tweets.map do |tweet|
      PopgunTweet.new(tweet).artists_mentioned(artist_delimiter).map do |artist|
        PopgunFeedRecommendation.new(
          tweet: tweet,
          artist: artist,
          feed_id: recommendation_feed_id
        )
      end.select(&:top_spotify_track)
    end.flatten
  end

  def twitter_feed
    @twitter_feed ||= TwitterFeed.new(screen_name)
  end
end
