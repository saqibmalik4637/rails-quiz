class Room < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  belongs_to :quiz

  has_many :room_users
  has_many :users, through: :room_users, source: :user
  has_many :report_cards, dependent: :destroy

  enum status: { is_open: 0, is_closed: 1 }

  def quiz_image
    quiz.image_url(size: :medium)
  end

  def quiz_name
    quiz.name
  end

  def scoreboard
    pre_position_result = users.map do |user|
      report_card = report_cards.find_by(user_id: user.id, quiz_id: quiz.id)

      {
        "name" => user.fullname,
        "score" => report_card.present? ? report_card.score : 0,
        "in_progress" => !report_card.present?
      }
    end

    post_position_result = pre_position_result
                            .sort_by{|data|data["score"]}
                            .reverse
                            .each_with_index
                            .map{|data, i|data.merge({"position" => i+1})}
  end
end
