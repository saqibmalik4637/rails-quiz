class QuestionAnswer < ApplicationRecord
  #Associations
  belongs_to :question
  belongs_to :option
end
