class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :rememberable, :trackable, :omniauthable, omniauth_providers: [:spotify]

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
end
