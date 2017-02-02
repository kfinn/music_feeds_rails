'use strict'

class SpotifyPlaylistPlayer extends React.Component {
  render () {
    return (
      <div className="SpotifyPlaylistPlayer">
        <iframe className="SpotifyPlaylistPlayer-iframe" src={this.getFrameSrc()} width="300" height="80" frameBorder="0" allowTransparency="true" />
      </div>
    );
  }

  getFrameSrc() {
    return "https://embed.spotify.com?uri=" + this.getURI();
  }

  getURI() {
    return "spotify:trackset:Feed:" + this.getTrackIDs().join(',');
  }

  getTrackIDs() {
    return this.props.songs.map((song) => song.spotifyId).filter((id) => id);
  }
}
