# frozen_string_literal: true

class SongsController < UnauthenticatedController
  def index
    @songs =
      Song
      .interesting_to_user(current_user)
      .ordered
      .page(params[:page])
      .includes(:recommendations)
  end

  def show
    @song = Song.find(params[:id])
  end

  def edit
    ensure_admin_user!
    @song = Song.find(params[:id])
    @song.assign_attributes update_params
  end

  def update
    ensure_admin_user!
    @song = Song.find(params[:id])
    if @song.update update_params
      redirect_to(song_path(@song))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_params
    params.permit(song: %i[artist title])[:song] || {}
  end
end
