class UpdatesController < UnauthenticatedController
  def create
    Feed.find(params[:feed_id]).update_from_remote!
    redirect_to(update_path(params[:feed_id]))
  end
end
