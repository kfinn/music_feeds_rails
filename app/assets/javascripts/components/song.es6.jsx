"use strict"

class Song extends React.Component {
  render () {
    return (
      <div className="Song">
        <div className="Song-playButton">
          <SpotifySongPlayer song={this.props.song}/>
        </div>
        <div className="Song-details">
          <span className="Song-artist">{ this.props.song.artist }</span> &mdash; <span className="Song-title">{ this.props.song.title }</span>
        </div>
      </div>
    );
  }
}
