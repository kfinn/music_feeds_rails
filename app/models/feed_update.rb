class FeedUpdate
  def perform!
    Feed.all.each &:update
    true
  end
end
