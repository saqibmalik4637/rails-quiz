class Carousel < ApplicationRecord

  enum classification: {
    trending: 0,
    personalized: 1,
    age_based: 2,
    geographic: 3,
    most_played: 4,
    new_topics: 5
  }

  def quiz_type?
    type.eql?('QuizCarousel')
  end

  def category_type?
    type.eql?('CategoryCarousel')
  end

  def homepage_items(user:, limit:)
    Rails.cache.fetch("carousel_#{id}_user_#{user.id}_#{limit}", expires_in: 1.hour) do
      case classification
      when 'trending' then trending_content(user)
      when 'personalized' then personalized_content(user)
      when 'age_based' then age_based_content(user)
      when 'geographic' then geographic_content(user)
      when 'most_played' then most_played_content(user)
      when 'new_topics' then new_topics_content(user)
      else random_content
      end.limit(limit)
    end
  end
end
