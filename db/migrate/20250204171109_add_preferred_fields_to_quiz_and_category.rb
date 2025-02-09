class AddPreferredFieldsToQuizAndCategory < ActiveRecord::Migration[7.0]
  def change
    add_column :quizzes, :preferred_countries, :jsonb, default: [], null: false
    add_column :quizzes, :preferred_min_age, :integer
    add_column :quizzes, :preferred_max_age, :integer

    add_column :categories, :preferred_countries, :jsonb, default: [], null: false
    add_column :categories, :preferred_min_age, :integer
    add_column :categories, :preferred_max_age, :integer

    add_index :quizzes, :preferred_countries, using: :gin
    add_index :categories, :preferred_countries, using: :gin
  end
end
