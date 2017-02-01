module SongsHelper
  def spotify_player_for(songs)
    tag(:iframe, src: "https://embed.spotify.com/?uri=#{spotify_uri_for songs}", frameborder: '0', allowtransparency: 'true')
  end

  private
  def spotify_uri_for(songs)
    "spotify:trackset:Feed:#{songs.map(&:spotify_id).compact.join(',')}"
  end
end
