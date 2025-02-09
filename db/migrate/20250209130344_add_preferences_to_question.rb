class AddPreferencesToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :preferred_max_age, :integer
    add_column :questions, :preferred_min_age, :integer
    add_column :questions, :preferred_countries, :jsonb, default: []

    add_index :questions, :preferred_countries, using: :gin
    add_index :questions, :preferred_max_age
    add_index :questions, :preferred_min_age
  end
end
