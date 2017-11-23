# frozen_string_literal: true

class AllFeedUpdatesController < UnauthenticatedController
  def create
    Feed.all.each { |feed| feed.feed_updates.create! }
    redirect_to songs_path
  end
end
