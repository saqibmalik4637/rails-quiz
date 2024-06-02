require 'jwt'

class User < ApplicationRecord
  has_many :user_quizzes
  has_many :quiz_favorites, -> { where is_favorited: true }, class_name: 'UserQuiz', foreign_key: :user_id
  has_many :favorited_quizzes, through: :quiz_favorites, class_name: 'Quiz', source: :quiz
  has_many :quiz_plays, -> { where is_played: true }, class_name: 'UserQuiz', foreign_key: :user_id
  has_many :played_quizzes, through: :quiz_plays, class_name: 'Quiz', source: :quiz
  has_many :created_rooms, class_name: 'Room', foreign_key: :user_id

  has_many :follower_relationships, foreign_key: :followee_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :followee_relationships, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :followees, through: :followee_relationships, source: :followee

  def jwt_token
    payload = { user_id: id }
    token = JWT.encode payload, nil, 'none'
  end

  # Follow a user
  def follow(user)
    followee_relationships.create(followee_id: user.id)
  end

  # Unfollow a user
  def unfollow(user)
    followee_relationships.find_by(followee_id: user.id).destroy
  end

  # Check if following a user
  def following?(user)
    followees.include?(user)
  end
end
