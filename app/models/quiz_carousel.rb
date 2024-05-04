class QuizCarousel < Carousel
  has_many :quizzes, through: :carousel_items, source_type: 'Quiz', source: :collectable

  def homepage_items
    quizzes.joins(:carousel_items).where(carousel_items: { show_on_homepage: true }).distinct
  end
end
