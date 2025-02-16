class Api::V1::CategoriesController < Api::V1::BaseController
  def index
    if params[:query].present?
      search_service = SearchService.new(query: params[:query])
      @categories = search_service.categories
    elsif params[:carousel_id].present?
      @carousel = Carousel.find(params[:carousel_id])
      @categories = @carousel.homepage_items(user: current_user, limit: 100)
    else
      @categories = Category.all
    end
  end
end
