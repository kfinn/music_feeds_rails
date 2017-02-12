class SpotifySyncsController < ApplicationController
  def create
    playlist = current_user.playlists.find(params[:playlist_id])
    playlist.sync_to_spotify!
    redirect_to playlist_path(playlist)
  end
end
