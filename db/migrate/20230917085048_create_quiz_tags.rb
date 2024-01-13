class CreateQuizTags < ActiveRecord::Migration[7.0]
  def change
    create_table :quiz_tags do |t|
      t.references :quiz
      t.references :tag

      t.timestamps
    end
  end
end
