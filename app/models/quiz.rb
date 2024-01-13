class Quiz < ApplicationRecord
  #Associations
  belongs_to :category

  has_many :quiz_tags, dependent: :destroy
  has_many :tags, through: :quiz_tags
  has_many :questions, dependent: :nullify
end
