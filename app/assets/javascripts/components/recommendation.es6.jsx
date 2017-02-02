class Recommendation extends React.Component {
  render () {
    return (
      <div className="Recommendation">
        <a className="Recommendation-authorLink" href={ this.props.recommendation.url }>
          { this.props.recommendation.creator }
        </a>
        <span className="Recommendation-recommendedAt">
          { moment(this.props.recommendation.recommendedAt).calendar() }
        </span>
      </div>
    );
  }
}
