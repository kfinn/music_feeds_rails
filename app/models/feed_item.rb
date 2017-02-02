class FeedItem
  def initialize(xml)
    @xml = xml
  end

  def guid
    xml.css('guid').text
  end

  def url
    xml.css('link').text
  end

  def creator
    xml.xpath('dc:creator').text
  end

  def description
    xml.css('description').text
  end

  def recommended_at
    xml.css('pubDate').text
  end

  def song_artist
    raw_title.split(TITLE_SEPARATOR).first.strip
  end

  def categories
    xml.css('category').map &:text
  end

  def song_title
    raw_title.sub(/^[^#{TITLE_SEPARATOR}]*#{TITLE_SEPARATOR}/, '').sub(/ Video$/, '').strip
  end

  def interesting?
    song? && !metal?
  end

  def metal?
    xml.css('description').text.include? 'metal'
  end

  def song?
    raw_title.include? TITLE_SEPARATOR
  end

  attr_reader :xml

  def raw_title
    xml.css('title').text
  end

  TITLE_SEPARATOR = '–'
end
