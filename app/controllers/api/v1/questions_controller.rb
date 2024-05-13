class Api::V1::QuestionsController < Api::V1::BaseController
  def index
    @quiz = Quiz.find(params[:quiz_id])
    @questions = @quiz.questions.includes(:options, :answer)
  end
end
