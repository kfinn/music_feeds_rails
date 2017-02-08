class SongsController < ApplicationController
  def index
    @songs = Song.interesting.ordered.includes(:recommendations).page params[:page]
  end
end
