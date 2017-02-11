class RecommendationsController < UnauthenticatedController
  def index
    @recommendations = Recommendation.interesting.ordered.page params[:page]
  end

  def show
    @recommendation = Recommendation.find(params[:id])
  end
end
