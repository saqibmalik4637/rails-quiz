class QuizCarousel < Carousel

  # Trending: Mix of popularity and recent engagement
  def trending_content(user)
    content = Quiz.verified
      .joins(:report_cards)
      .where('report_cards.created_at >= ?', 1.week.ago)
      .where("quizzes.preferred_countries @> ? OR quizzes.preferred_countries = '[]'::jsonb", [user.country_code].to_json)
      .group('quizzes.id')
      .order('COUNT(report_cards.id) DESC, played_count DESC')
      .select('quizzes.*, COUNT(report_cards.id) AS recent_plays')

    content = random_content unless content.present?

    content
  end

  # Personalized: Based on user interests and social connections
  def personalized_content(user)
    content = Quiz.verified
      .select('quizzes.*, RANDOM() AS ordering_key')
      .joins(:interests)
      .where(interests: { id: user.interest_ids })
      .or(Quiz.where(id: user.favorited_quiz_ids))
      .where("quizzes.preferred_countries @> ? OR quizzes.preferred_countries = '[]'::jsonb", [user.country_code].to_json)
      .group('quizzes.id')
      .order('ordering_key DESC')

    content = random_content unless content.present?

    content
  end

  # Age-based: Quizzes suitable for user's age group
  def age_based_content(user)
    content = Quiz.verified
      .where('preferred_min_age <= ? AND preferred_max_age >= ?', user.age, user.age)
      .where("preferred_countries @> ? OR preferred_countries = '[]'::jsonb", [user.country_code].to_json)
      .order(played_count: :desc)

    content = random_content unless content.present?

    content
  end

  # Geographic: Popular in user's country
  def geographic_content(user)
    content = Quiz.verified
      .where("preferred_countries @> ? OR quizzes.preferred_countries = '[]'::jsonb", [user.country_code].to_json)
      .order(played_count: :desc)

    content = random_content unless content.present?

    content
  end

  # Most Played: All-time favorites
  def most_played_content(user)
    content = Quiz.verified
      .order(played_count: :desc)

    content = random_content unless content.present?

    content
  end

  # New Topics: Recently created and less explored
  def new_topics_content(user)
    content = Quiz.verified
      .left_joins(:report_cards)
      .group('quizzes.id')
      .order('quizzes.created_at DESC, COUNT(report_cards.id) ASC')
      .where('quizzes.created_at >= ?', 2.weeks.ago)

    content = random_content unless content.present?

    content
  end

  def random_content
    Quiz.verified.order("RANDOM()")
  end
end
