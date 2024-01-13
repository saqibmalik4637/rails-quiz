class Question < ApplicationRecord
  # Associations
  belongs_to :quiz

  has_many :question_options, dependent: :destroy
  has_many :options, through: :question_options

  has_one :question_answer, dependent: :destroy
  has_one :answer, through: :question_answer, source: :option

  # INSTANCE METHODS
  def options_json
    options.map(&:as_json)
  end

  def answer_json
    answer.as_json
  end
end
