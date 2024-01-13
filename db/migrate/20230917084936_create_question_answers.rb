class CreateQuestionAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :question_answers do |t|
      t.references :question
      t.references :option

      t.timestamps
    end
  end
end
