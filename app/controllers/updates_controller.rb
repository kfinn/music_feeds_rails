# frozen_string_literal: true

class UpdatesController < UnauthenticatedController
  def create
    Feed.find(params[:feed_id]).feed_updates.create!
    redirect_to update_path(Feed.find(params[:feed_id]).feed_updates.create!)
  end

  def show
    @feed_update = FeedUpdate.find(params[:id])
  end
end
