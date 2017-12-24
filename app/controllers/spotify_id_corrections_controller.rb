# frozen_string_literal: true

class SpotifyIdCorrectionsController < ApplicationController
  def new
    song = Song.find(params[:song_id])
    @spotify_id_correction = song.build_spotify_id_correction create_params
    @spotify_id_correction.assign_attributes create_params
  end

  def create
    song = Song.find(params[:song_id])
    @spotify_id_correction = song.build_spotify_id_correction create_params
    if @spotify_id_correction.save
      redirect_to song_path(@spotify_id_correction.song)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.permit(spotify_id_correction: :spotify_id)[:spotify_id_correction] || {}
  end
end
