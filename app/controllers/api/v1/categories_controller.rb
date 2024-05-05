class Api::V1::CategoriesController < Api::V1::BaseController
  skip_before_action :authenticate_user
  def index
    if params[:query].present?
      search_service = SearchService.new(query: params[:query])
      @categories = search_service.categories
    else
      @categories = Category.all
    end
  end
end
