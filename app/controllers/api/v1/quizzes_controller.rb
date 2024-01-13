class Api::V1::QuizzesController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @quizzes = @category.quizzes
  end
end
