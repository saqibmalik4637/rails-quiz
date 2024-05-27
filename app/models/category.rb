class Category < ApplicationRecord
  #Associations
  has_many :quizzes, dependent: :destroy
  has_many :carousel_items, as: :collectable, dependent: :destroy
  has_many :carousels, through: :carousel_items

  # Attachments
  has_one_attached :image

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
  def image_url
    image.url
  end

  def quizzes_count
    quizzes.size
  end
end
