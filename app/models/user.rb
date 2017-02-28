class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :rememberable, :trackable, :omniauthable, omniauth_providers: [:spotify]

  has_many :playlists
  has_many :spotify_syncs, through: :playlists

  def self.from_omniauth(omniauth)
    find_by(spotify_uid: omniauth[:uid]) || create_from_omniauth!(omniauth)
  end

  def self.create_from_omniauth!(omniauth)
    create!(
      spotify_uid: omniauth[:uid],
      email: omniauth[:info][:email],
      spotify_credential_token: omniauth[:credentials][:token],
      spotify_credential_refresh_token: omniauth[:credentials][:refresh_token],
      spotify_credential_expires_at: Time.zone.at(omniauth[:credentials][:expires_at]).to_datetime,
      spotify_credential_expires: omniauth[:credentials][:expires]
    )
  end

  def rspotify_user
    @rspotify_user ||= RSpotify::User.new to_rspotify_params
  end

  private

  def to_rspotify_params
    {
      info: {
        id: spotify_uid,
        email: email
      },
      credentials: {
        token: spotify_credential_token,
        refresh_token: spotify_credential_refresh_token,
        expires_at: spotify_credential_expires_at.to_i,
        expires: spotify_credential_expires
      }
    }.with_indifferent_access
  end
end
