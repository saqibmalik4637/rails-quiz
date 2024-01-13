class Api::V1::QuestionsController < ApplicationController
  def index
    @quiz = Quiz.find(params[:quiz_id])
    @questions = @quiz.questions
  end
end
