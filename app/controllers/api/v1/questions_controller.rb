class Api::V1::QuestionsController < Api::V1::BaseController
  skip_before_action :authenticate_user
  def index
    @quiz = Quiz.find(params[:quiz_id])
    @questions = @quiz.questions.includes(:options, :answer)
  end
end
