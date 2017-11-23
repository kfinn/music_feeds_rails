# frozen_string_literal: true

class SongsController < UnauthenticatedController
  def index
    @songs = Song.interesting.ordered.page params[:page]
  end

  def show
    @song = Song.find(params[:id])
  end
end
