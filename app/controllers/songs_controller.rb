class SongsController < ApplicationController
  def index
    @songs = Song.interesting.ordered.page params[:page]
  end
end
