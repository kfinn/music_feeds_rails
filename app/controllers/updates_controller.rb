class UpdatesController < ApplicationController
  def create
    Feed.find(params[:feed_id]).update!
    redirect_to(feed_path(params[:feed_id]))
  end
end
