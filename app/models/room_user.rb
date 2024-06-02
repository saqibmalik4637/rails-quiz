class RoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :room

  enum status: { active: 0, inactive: 1 }
end
