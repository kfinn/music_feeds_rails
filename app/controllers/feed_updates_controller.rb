class FeedUpdatesController < ApplicationController
  def create
    FeedUpdate.new.perform!
    redirect_to songs_path
  end
end
