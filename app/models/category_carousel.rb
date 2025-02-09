class CategoryCarousel < Carousel

  # Trending: Categories with recent engagement
  def trending_content(user)
    Category.joins(quizzes: :report_cards)
      .where('report_cards.created_at >= ?', 1.week.ago)
      .group('categories.id')
      .order('COUNT(report_cards.id) DESC')
      .select('categories.*, COUNT(report_cards.id) AS recent_activity')
  end

  # Personalized: Based on user interests
  def personalized_content(user)
    Category.select('categories.*, RANDOM() AS ordering_key')
      .joins(quizzes: :interests)
      .where(interests: { id: user.interest_ids })
      .group('categories.id')
      .order('ordering_key DESC')
  end

  # Age-based: Categories popular with user's age group
  def age_based_content(user)
    Category.joins(quizzes: :report_cards)
      .where('categories.preferred_min_age <= ? AND categories.preferred_max_age >= ?', user.age, user.age)
      .group('categories.id')
      .order('COUNT(report_cards.id) DESC')
  end

  # Geographic: Popular categories in user's country
  def geographic_content(user)
    Category.joins(quizzes: :report_cards)
      .where("categories.preferred_countries @> ?", [user.country_code].to_json)
      .group('categories.id')
      .order('COUNT(report_cards.id) DESC')
  end

  # Most Played: Categories with most played quizzes
  def most_played_content(user)
    Category.joins(:quizzes)
      .group('categories.id')
      .order('SUM(quizzes.played_count) DESC')
      .select('categories.*, SUM(quizzes.played_count) AS total_plays')
  end

  # New Topics: Categories with recent additions
  def new_topics_content(user)
    Category.select('categories.*, MAX(quizzes.created_at) AS ordering_key')
      .joins(:quizzes)
      .where('quizzes.created_at >= ?', 2.weeks.ago)
      .group('categories.id')
      .order('ordering_key DESC')
      .distinct
  end

  def random_content
    Category.order("RANDOM()")
  end
end
