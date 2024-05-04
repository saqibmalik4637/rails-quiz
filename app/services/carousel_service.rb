class CarouselService
  def self.create_category_carousels
    category_ids = Category.all.pluck(:id)
    used_category_ids = []

    CategoryCarousel.all.each do |carousel|
      items_count = 0

      while items_count < 12
        category_id = category_ids.sample
        unless used_category_ids.include?(category_id)
          category = Category.find(category_id)
          CarouselItem.create(carousel: carousel, collectable: category, show_on_homepage: true)
          used_category_ids << category_id
          items_count += 1
        end
      end
    end
  end

  def self.create_quiz_carousels
    quiz_ids = Quiz.all.pluck(:id)
    used_quiz_ids = []

    QuizCarousel.all.each do |carousel|
      items_count = 0

      while items_count < 12
        quiz_id = quiz_ids.sample
        unless used_quiz_ids.include?(quiz_id)
          quiz = Quiz.find(quiz_id)
          CarouselItem.create(carousel: carousel, collectable: quiz, show_on_homepage: true)
          used_quiz_ids << quiz_id
          items_count += 1
        end
      end
    end
  end
end
