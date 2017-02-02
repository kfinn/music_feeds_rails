'use strict'

class Playlist extends React.Component {
  render() {
    return (
      <div className="Playlist">
        <h1 className="Playlist-title">Songs</h1>
        <div className="Playlist-player">
          <SpotifyPlaylistPlayer songs={this.props.songs} onTrackChanged={(player) => this.handleTrackChanged(player)}/>
        </div>
        <ul className="Playlist-songList">
        { this.props.songs.map((song) =>
            <li key={song.key} className="Playlist-songListItem">
              <Song song={song} />
            </li>
        )}
        </ul>
      </div>
    );
  }
}

Playlist.propTypes = {
  songs: React.PropTypes.array
};
