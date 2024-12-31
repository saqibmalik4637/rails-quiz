json.(
  category,
  :id,
  :name,
  :quizzes_count
)

json.image_url category.image_url(size: params[:image_size] || :medium)
