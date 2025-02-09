class CarouselService
  def self.create_category_carousels
    [
      {
        "title": "Popular Categories",
        "description": "Explore the most engaging categories in your region.",
        "position": 2,
        "classification": "trending"
      },
      {
        "title": "Categories for You",
        "description": "Find categories that match your hobbies and passions.",
        "position": 4,
        "classification": "personalized"
      },
      {
        "title": "Explore New Topics",
        "description": "Dive into fresh and exciting topics you haven’t explored yet.",
        "position": 6,
        "classification": "new_topics"
      }
    ].each do |data|
      CategoryCarousel.create(
        title: data[:title],
        description: data[:description],
        position: data[:position],
        classification: data[:classification]
      )
    end
  end

  def self.create_quiz_carousels
    [
      {
        "title": "Trending Quizzes",
        "description": "Discover the most popular quizzes in your region.",
        "position": 1,
        "classification": "trending"
      },
      {
        "title": "Quizzes for Your Age Group",
        "description": "Handpicked quizzes tailored to your age group.",
        "position": 7,
        "classification": "age_based"
      },
      {
        "title": "Quizzes You Might Like",
        "description": "Personalized quiz recommendations based on your interests.",
        "position": 3,
        "classification": "personalized"
      },
      {
        "title": "Most Played Quizzes",
        "description": "Join thousands of users in playing the most popular quizzes.",
        "position": 5,
        "classification": "most_played"
      }
    ].each do |data|
      QuizCarousel.create(
        title: data[:title],
        description: data[:description],
        position: data[:position],
        classification: data[:classification]
      )
    end
  end
end
