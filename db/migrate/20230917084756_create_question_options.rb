class CreateQuestionOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :question_options do |t|
      t.references :question
      t.references :option

      t.timestamps
    end
  end
end
