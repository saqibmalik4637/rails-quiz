class Interest < ApplicationRecord
  has_many :user_interests, dependent: :destroy
  has_many :users, through: :user_interests
  has_many :quiz_interests, dependent: :destroy
  has_many :quizzes, through: :quiz_interests
end
