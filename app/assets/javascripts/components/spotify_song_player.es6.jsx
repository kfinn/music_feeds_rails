class SpotifySongPlayer extends React.Component {
  render() {
    if (this.props.song.spotifyId) {
      return (
        <div className="SpotifySongPlayer">
          <iframe className="SpotifySongPlayer-iframe" src={this.getFrameSrc()} width="80" height="80" frameBorder="0" allowTransparency="true" />
        </div>
      );
    } else {
      return null;
    }
  }

  getFrameSrc() {
    return "https://embed.spotify.com?uri=" + this.getURI();
  }

  getURI() {
    return "spotify:track:" + this.props.song.spotifyId;
  }
}
