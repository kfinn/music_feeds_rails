class FeedUpdate
  def perform!
    Song.transaction do
      Feed.new.feed_items.select(&:interesting?).each do |feed_item|
        Song.find_or_create_by! title: feed_item.title, artist: feed_item.artist
      end
    end
  end
end
