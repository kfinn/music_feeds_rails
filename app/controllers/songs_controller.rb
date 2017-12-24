# frozen_string_literal: true

class SongsController < UnauthenticatedController
  def index
    @songs =
      Song
      .interesting
      .ordered
      .page(params[:page])
      .includes(:recommendations)
  end

  def show
    @song = Song.find(params[:id])
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    if @song.update update_params
      redirect_to(song_path(@song))
    else
      render :edit, status: :unprocessable_entity
    end
  end
end
