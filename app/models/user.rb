require 'jwt'

class User < ApplicationRecord
  has_many :user_quizzes
  has_many :quiz_favorites, -> { where is_favorited: true }, class_name: 'UserQuiz', foreign_key: :user_id
  has_many :favorited_quizzes, through: :quiz_favorites, class_name: 'Quiz', source: :quiz
  has_many :quiz_plays, -> { where is_played: true }, class_name: 'UserQuiz', foreign_key: :user_id
  has_many :played_quizzes, through: :quiz_plays, class_name: 'Quiz', source: :quiz

  def jwt_token
    payload = { user_id: id }
    token = JWT.encode payload, nil, 'none'
  end
end
