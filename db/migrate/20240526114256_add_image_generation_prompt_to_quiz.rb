class AddImageGenerationPromptToQuiz < ActiveRecord::Migration[7.0]
  def change
    add_column :quizzes, :image_generation_prompt, :text
  end
end
