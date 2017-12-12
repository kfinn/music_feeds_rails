# frozen_string_literal: true

class SpotifyIdCorrectionsController < ApplicationController
  def edit
    song = Song.find(params[:song_id])
    @spotify_id_correction = current_user.spotify_id_correction_for_song(song)
    @spotify_id_correction.assign_attributes update_params
  end

  def update
    song = Song.find(params[:song_id])
    @spotify_id_correction = current_user.spotify_id_correction_for_song(song)
    if @spotify_id_correction.update(update_params)
      redirect_to song_path(@spotify_id_correction.song), flash: 'Spotify ID updated'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def update_params
    params.permit(spotify_id_correction: :spotify_id)
  end
end
