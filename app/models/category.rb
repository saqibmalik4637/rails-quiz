class Category < ApplicationRecord
  #Associations
  has_many :quizzes, dependent: :destroy
  has_many :carousel_items, as: :collectable, dependent: :destroy
  has_many :carousels, through: :carousel_items

  # CLASS METHODS
  def self.search(query)
    result = if query.present?
      query = query.downcase
      query_string = "LOWER(categories.name) LIKE '%#{query}%' "
      query_string += "OR LOWER(quizzes.name) LIKE '%#{query}%' "
      query_string += "OR LOWER(carousels.title) LIKE '%#{query}%'"
      left_joins(:quizzes, :carousels).where(query_string).distinct
    else
      all
    end

    result
  end

  # INSTANCE METHODS
  def image
    { uri: "https://media.istockphoto.com/id/1268465415/photo/quiz-time-concept-speech-bubble-with-pencil-on-yellow-background.jpg?s=612x612&w=0&k=20&c=ZowfYpCJeyknpWhnfyWqV1_If6aJmFUiSqqqEUBhvAg=" }
  end

  def quizzes_count
    quizzes.size
  end
end
