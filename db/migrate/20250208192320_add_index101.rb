class AddIndex101 < ActiveRecord::Migration[7.0]
  def change
    add_index :quizzes, [:verified, :played_count]
    add_index :report_cards, [:created_at]
  end
end
