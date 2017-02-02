class SongsController < ApplicationController
  def index
    @songs = Song.ordered
  end
end
