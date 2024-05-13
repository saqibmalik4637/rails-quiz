class AddTotalPointsToQuiz < ActiveRecord::Migration[7.0]
  def change
    add_column :quizzes, :total_points, :integer, default: 1000
  end
end
