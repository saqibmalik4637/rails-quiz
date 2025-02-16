class Category < ApplicationRecord
  #Associations
  has_many :quizzes, dependent: :destroy

  # Attachments
  has_one_attached :image, dependent: :destroy

  # Scopes
  scope :with_attachment, -> { includes(image_attachment: :blob) }

  # CLASS METHODS
  def self.search(query)
    result = if query.present?
      query = query.downcase
      query_string = "LOWER(categories.name) LIKE '%#{query}%' "
      query_string += "OR LOWER(quizzes.name) LIKE '%#{query}%' "
      with_attachment.left_joins(:quizzes).where(query_string).distinct
    else
      with_attachment.all
    end

    result
  end

  # INSTANCE METHODS
  def image_url(size: :default)
    if image.attached?
      variant = case size
                when :thumbnail
                  image.variant(resize_to_fill: [100, 100]) # Thumbnail version
                when :medium
                  image.variant(resize_to_limit: [600, 600]) # Medium-sized image
                else
                  image # Default size (original)
                end
      Rails.application.routes.url_helpers.rails_blob_url(variant, only_path: false) + "?v=#{updated_at.to_i}"
    else
      "https://quizwithai.in#{ActionController::Base.helpers.asset_path('quizzes/quiz-placeholder.webp')}"
    end
  end

  def quizzes_count
    quizzes.verified.size
  end
end
