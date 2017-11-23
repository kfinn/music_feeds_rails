# frozen_string_literal: true

class PlaylistsController < ApplicationController
  def index
    @playlists = current_user.playlists.page params[:page]
  end

  def show
    @playlist = current_user.playlists.find params[:id]
  end

  def new
    @playlist = current_user.playlists.build create_params
  end

  def create
    @playlist = current_user.playlists.build create_params
    if @playlist.save
      flash[:notice] = 'Playlist created'
      redirect_to playlist_path(@playlist.id)
    else
      flash[:alert] = 'Unable to create playlist'
      render :new
    end
  end

  private

  def create_params
    params.permit(playlist: [:name])[:playlist]
  end
end
