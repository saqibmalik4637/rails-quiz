class Room < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  belongs_to :quiz

  has_many :room_users
  has_many :users, through: :room_users, source: :user

  enum status: { is_open: 0, is_closed: 1 }

  def quiz_image
    quiz.image_url
  end

  def quiz_name
    quiz.name
  end
end
