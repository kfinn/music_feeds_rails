class RecommendationList extends React.Component {
  render() {
    return (
      <ul className="RecommendationList">
      { this.props.recommendations.map((recommendation) =>
        <li key={ recommendation.id }>
          <Recommendation recommendation={ recommendation }/>
        </li>
      )}
      </ul>
    );
  }
}
