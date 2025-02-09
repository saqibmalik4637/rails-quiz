class AddIndexesToQuizCategoryUserInterest < ActiveRecord::Migration[7.0]
  def change
    add_index :quizzes, [:preferred_min_age, :preferred_max_age]
    add_index :categories, [:preferred_min_age, :preferred_max_age]
    add_index :quiz_interests, [:quiz_id, :interest_id]
  end
end
