json.(
  carousel,
  :id,
  :title,
  :description,
  :type
)

if carousel.quiz_type?
  json.items carousel.homepage_items, partial: 'api/v1/quizzes/quiz', as: :quiz
elsif carousel.category_type?
  json.items carousel.homepage_items, partial: 'api/v1/categories/category', as: :category
end
