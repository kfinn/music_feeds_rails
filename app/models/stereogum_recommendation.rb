class StereogumRecommendation
  include RssRecommendation
  feed_id :stereogum

  def initialize(rss)
    @rss = rss
  end

  def song_artist
    raw_title.split(TITLE_SEPARATOR).first.strip
  end

  def song_title
    TITLE_REGEX.match(raw_title)[1]
  end

  def song?
    raw_title.include? TITLE_SEPARATOR && TITLE_REGEX.match(raw_title)
  end

  def raw_title
    rss.title
  end

  TITLE_SEPARATOR = '–'
  TITLE_REGEX = /["“\u2033]([^"”\u2033]+)[”"\u2033]/
end
