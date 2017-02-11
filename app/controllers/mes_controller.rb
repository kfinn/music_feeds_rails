class MesController < ApplicationController
  def show
    @me = current_user
    @playlists = current_user.playlists.page params[:page]
  end
end
