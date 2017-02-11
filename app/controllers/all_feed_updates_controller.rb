class AllFeedUpdatesController < UnauthenticatedController
  def create
    Feed.all.each &:update!
    redirect_to songs_path
  end
end
