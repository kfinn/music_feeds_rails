class FeedItem
  def initialize(xml)
    @xml = xml
  end

  def artist
    categories.select do |category|
      raw_title.start_with? category
    end.first
  end

  def categories
    xml.css('category').map &:text
  end

  def title
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

  def guid
    xml.css('guid').text
  end

  attr_reader :xml

  def raw_title
    xml.css('title').text
  end

  TITLE_SEPARATOR = '–'
end
