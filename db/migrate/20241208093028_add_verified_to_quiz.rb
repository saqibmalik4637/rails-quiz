class AddVerifiedToQuiz < ActiveRecord::Migration[7.0]
  def change
    add_column :quizzes, :verified, :boolean, default: false
  end
end
