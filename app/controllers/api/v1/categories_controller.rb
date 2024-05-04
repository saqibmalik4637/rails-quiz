class Api::V1::CategoriesController < Api::V1::BaseController
  def index
    if params[:query].present?
      search_service = SearchService.new(query: params[:query])
      @categories = search_service.categories
    else
      @categories = Category.all
    end
  end
end
