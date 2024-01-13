class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :quiz
      t.text :content

      t.timestamps
    end
  end
end
