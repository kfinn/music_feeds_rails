class FeedUpdate
  def perform!
    [StereogumFeed.new, PitchforkBestNewTracksFeed.new].each do |feed|
      feed.recommendations.each do |feed_item|
        Song.find_or_create_by!(title: feed_item.song_title, artist: feed_item.song_artist).tap do |song|
          song.recommendations.find_or_initialize_by(guid: feed_item.guid).update!({
            url: feed_item.url,
            creator: feed_item.creator,
            description: feed_item.description,
            recommended_at: feed_item.recommended_at
          })
        end
      end
    end
  end
end
