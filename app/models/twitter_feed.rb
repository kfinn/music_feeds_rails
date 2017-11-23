# frozen_string_literal: true

class TwitterFeed
  attr_reader :screen_name

  def initialize(screen_name)
    @screen_name = screen_name
  end

  def tweets
    client.user_timeline(screen_name, exclude_replies: true, include_rts: false, count: 200)
  end

  def client
    @client ||= Twitter::REST::Client.new(
      consumer_key: Rails.application.secrets.twitter_api_key,
      consumer_secret: Rails.application.secrets.twitter_api_secret
    )
  end
end
