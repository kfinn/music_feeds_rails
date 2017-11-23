# frozen_string_literal: true

class FeedsController < UnauthenticatedController
  def index
    @feeds = Feed.all
  end

  def show
    @feed = Feed.find params[:id]
    @recommendations = @feed.recommendations.ordered.page params[:page]
  end
end
