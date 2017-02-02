module SongsHelper
  def spotify_playlist_src_for(songs)
    spotify_src_for_uri "spotify:trackset:Feed:#{songs.map(&:spotify_id).compact.join(',')}"
  end

  def spotify_song_src_for(song)
    spotify_src_for_uri "spotify:track:#{song.spotify_id}"
  end

  def spotify_src_for_uri(uri)
    "https://embed.spotify.com?uri=#{uri}"
  end
end
