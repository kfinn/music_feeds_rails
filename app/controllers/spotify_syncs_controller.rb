# frozen_string_literal: true

class SpotifySyncsController < ApplicationController
  def create
    playlist = current_user.playlists.find params[:playlist_id]
    redirect_to spotify_sync_path(playlist.spotify_syncs.create!)
  end

  def show
    @spotify_sync = current_user.spotify_syncs.find params[:id]
  end
end
