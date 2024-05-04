class Api::V1::QuizzesController < Api::V1::BaseController
  def index
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @quizzes = @category.quizzes
    elsif params[:query].present?
      search_service = SearchService.new(query: params[:query])
      @quizzes = search_service.quizzes
    else
      @quizzes = Quiz.all
    end
  end

  def show
    @quiz = Quiz.find(params[:id])
  end
end
