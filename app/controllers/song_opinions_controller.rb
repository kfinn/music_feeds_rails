# frozen_string_literal: true

class SongOpinionsController < ApplicationController
  def create
    song = Song.find(params[:song_id])
    current_user
      .song_opinions
      .find_or_initialize_by(song: song)
      .update!(create_params)
    redirect_to songs_path
  end

  def create_params
    params.permit(song_opinion: :interesting)[:song_opinion] || {}
  end
end
