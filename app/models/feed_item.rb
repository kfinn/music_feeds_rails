class FeedItem
  def initialize(rss)
    @rss = rss
  end

  def guid
    rss.guid.content
  end

  def url
    rss.link
  end

  def creator
    rss.dc_creator
  end

  def description
    rss.description
  end

  def recommended_at
    rss.pubDate
  end

  def song_artist
    raw_title.split(TITLE_SEPARATOR).first.strip
  end

  def categories
    rss.categories.map &:content
  end

  def song_title
    raw_title.sub(/^[^#{TITLE_SEPARATOR}]*#{TITLE_SEPARATOR}/, '').sub(/ Video$/, '').strip
  end

  def song?
    raw_title.include? TITLE_SEPARATOR
  end

  attr_reader :rss

  def raw_title
    rss.title
  end

  TITLE_SEPARATOR = '–'
end
