class HomeController < ApplicationController
  def index
    @users = User.order(created_at: :desc).includes(:played_quizzes, :report_cards, :interests)
  end
end
