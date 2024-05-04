class AddDescriptionToQuiz < ActiveRecord::Migration[7.0]
  def change
    add_column :quizzes, :description, :text
    add_column :quizzes, :played_count, :bigint, default: 0
    add_column :quizzes, :favorited_count, :bigint, default: 0
    add_column :quizzes, :shared_count, :bigint, default: 0
  end
end
