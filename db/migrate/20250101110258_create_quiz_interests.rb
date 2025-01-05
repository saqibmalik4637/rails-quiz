class CreateQuizInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :quiz_interests do |t|
      t.references :quiz
      t.references :interest

      t.timestamps
    end
  end
end
