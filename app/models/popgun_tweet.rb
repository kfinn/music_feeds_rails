# frozen_string_literal: true

class PopgunTweet
  attr_reader :tweet

  def initialize(tweet)
    @tweet = tweet
  end

  def artists_mentioned(artist_delimiter)
    tweet.full_text.scan(/#{artist_delimiter}(.*)\n/).map(&:first).map do |unsanitized_artist|
      unsanitized_artist.split(%r{\s[Ww]/\s}).first
    end.map(&:strip)
  end
end
