class Tag < ApplicationRecord
  #Associations
  has_many :quiz_tags, dependent: :destroy
  has_many :quizzes, through: :quiz_tags
end
