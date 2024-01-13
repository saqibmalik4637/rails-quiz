class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.references :category
      t.string :name
      t.integer :questions_count

      t.timestamps
    end
  end
end
