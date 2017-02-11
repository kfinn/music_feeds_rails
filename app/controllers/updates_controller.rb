class UpdatesController < UnauthenticatedController
  def create
    Feed.find(params[:feed_id]).update!
    redirect_to(feed_path(params[:feed_id]))
  end
end
