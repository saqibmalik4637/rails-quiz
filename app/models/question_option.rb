class QuestionOption < ApplicationRecord
  #Associations
  belongs_to :question
  belongs_to :option
end
