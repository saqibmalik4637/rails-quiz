class Category < ApplicationRecord
  #Associations
  has_many :quizzes, dependent: :destroy

  # INSTANCE METHODS
  def image
    "https://previews.123rf.com/images/roywylam/roywylam1706/roywylam170600003/79996313-big-quiz-banner.jpg"
  end
end
