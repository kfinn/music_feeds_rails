class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def show
    @feed = Feed.find params[:id]
    @recommendations = @feed.recommendations.ordered.page params[:page]
  end
end
