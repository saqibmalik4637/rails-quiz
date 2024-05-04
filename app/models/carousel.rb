class Carousel < ApplicationRecord
  has_many :carousel_items

  def quiz_type?
    type.eql?('QuizCarousel')
  end

  def category_type?
    type.eql?('CategoryCarousel')
  end
end
