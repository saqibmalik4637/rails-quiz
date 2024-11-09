class ReportCard < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  belongs_to :room, optional: true

  after_create :handle_given_answers_json

  def handle_given_answers_json
    correct_answers_count = given_answers.select{|a|a["user_answer"].present? && a["user_answer"]["id"] == a["correct_answer"]["id"]}.size
    incorrect_answers_count = given_answers.select{|a|a["user_answer"].present? && a["user_answer"]["id"] != a["correct_answer"]["id"]}.size
    no_result_answers_count = given_answers.select{|a|!a["user_answer"].present?}.size

    sum_of_points = given_answers.map{|a|a["points"]}.sum

    update(correct_count: correct_answers_count, incorrect_count: incorrect_answers_count, no_result_count: no_result_answers_count, score: sum_of_points)
  end

  def quiz_total_points
    quiz.total_points
  end

  def quiz_category_name
    quiz.category.name
  end
end
