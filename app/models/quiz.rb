class Quiz < ApplicationRecord
  #Associations
  belongs_to :category

  has_many :quiz_tags, dependent: :destroy
  has_many :tags, through: :quiz_tags
  has_many :questions, dependent: :nullify
  has_many :carousel_items, as: :collectable, dependent: :destroy
  has_many :carousels, through: :carousel_items
  has_many :user_quizzes
  has_many :user_favorites, -> { where is_favorited: true }, class_name: 'UserQuiz', foreign_key: :quiz_id
  has_many :favorited_users, through: :user_favorites, class_name: 'User', source: :user
  has_many :user_plays, -> { where is_played: true }, class_name: 'UserQuiz', foreign_key: :quiz_id
  has_many :played_users, through: :user_plays, class_name: 'User', source: :user
  has_many :rooms

  has_one_attached :image

  # CLASS METHODS
  def self.search(query)
    result = if query.present?
      query = query.gsub("'", "").downcase
      query_string = "#{match_string_query('categories.name', query)} "
      query_string += "OR #{match_string_query('quizzes.name', query)} "
      query_string += "OR #{match_string_query('tags.name', query)} "
      query_string += "OR #{match_string_query('carousels.title', query)}"
      left_joins(:category, :tags, :carousels).where(query_string).distinct
    else
      all
    end

    result
  end

  def self.match_string_query(column_name, query)
    "LOWER(translate(#{column_name}, '-_""\''', '')) LIKE '%#{query}%'"
  end

  # INSTANCE METHODS
  def image_url
    if image.attached?
      image.url
    else
      [
        "https://0ae8-2401-4900-5d9e-733f-14b6-8a67-20c7-5d8c.ngrok-free.app#{ActionController::Base.helpers.asset_path('quizzes/quiz-time-travel')}",
        "https://0ae8-2401-4900-5d9e-733f-14b6-8a67-20c7-5d8c.ngrok-free.app#{ActionController::Base.helpers.asset_path('quizzes/time-travel-legends')}"
      ].sample
    end
  end

  def questions_count
    questions.size
  end

  def tags_json
    tags.to_json
  end

  def tags_string
    tags.pluck(:name).map(&:titlecase).join(', ')
  end
end
