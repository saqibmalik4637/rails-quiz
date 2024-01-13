class QuizTag < ApplicationRecord
  #Associations
  belongs_to :quiz
  belongs_to :tag
end
