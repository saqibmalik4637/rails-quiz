class CreateReportCards < ActiveRecord::Migration[7.0]
  def change
    create_table :report_cards do |t|
      t.references :quiz
      t.references :user
      t.integer :correct_count
      t.integer :incorrect_count
      t.integer :no_result_count
      t.decimal :total_points
      t.jsonb :given_answers, default: {}

      t.timestamps
    end
  end
end
