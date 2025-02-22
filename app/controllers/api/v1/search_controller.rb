class Api::V1::SearchController < Api::V1::BaseController
  def suggestions
    search_service = SearchService.new(query: params[:query])
    render json: { suggestions: search_service.suggestions }
  end
end
