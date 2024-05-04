if @category.present?
  json.category do
    json.partial! 'api/v1/categories/category', category: @category
  end
end

json.quizzes @quizzes, partial: 'api/v1/quizzes/quiz', as: :quiz
