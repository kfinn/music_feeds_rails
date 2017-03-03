class AllFeedUpdatesController < UnauthenticatedController
  def create
    Feed.all.each &:update_from_remote!
    redirect_to songs_path
  end
end
