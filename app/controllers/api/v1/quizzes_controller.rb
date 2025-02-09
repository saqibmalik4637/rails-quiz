class Api::V1::QuizzesController < Api::V1::BaseController
  def index
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @quizzes = @category.quizzes.verified
    elsif params[:carousel_id].present?
      @carousel = Carousel.find(params[:carousel_id])
      @carousel.homepage_items(user: current_user, limit: 100)
    elsif params[:query].present?
      search_service = SearchService.new(query: params[:query])
      @quizzes = search_service.quizzes
    else
      @quizzes = Quiz.verified
    end
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def mark_favorited
    @quiz = Quiz.find(params[:id])
    @user_quiz = current_user.user_quizzes.find_by(quiz: @quiz)

    if @user_quiz.present?
      @user_quiz.update(is_favorited: true)
    else
      @user_quiz = current_user.user_quizzes.create(quiz: @quiz, is_favorited: true)
    end

    @quiz.update(favorited_count: @quiz.favorited_count + 1)
  end

  def unmark_favorited
    @quiz = Quiz.find(params[:id])
    @user_quiz = current_user.user_quizzes.find_by(quiz: @quiz)

    if @user_quiz.present?
      @user_quiz.update(is_favorited: false)
    end

    @quiz.update(favorited_count: @quiz.favorited_count - 1)
  end

  def mark_played
    @quiz = Quiz.find(params[:id])
    @user_quiz = current_user.user_quizzes.find_by(quiz: @quiz)

    if @user_quiz.present?
      @user_quiz.update(is_played: true)
    else
      @user_quiz = current_user.user_quizzes.create(quiz: @quiz, is_played: true)
    end

    @quiz.update(played_count: @quiz.played_count + 1)
  end
end
