json.(
  quiz,
  :id,
  :name,
  :description,
  :total_points,
  :questions_count,
  :tags_json,
  :tags_string,
  :played_count,
  :favorited_count,
  :shared_count
)

json.image_url quiz.image_url(size: params[:image_size] || :medium)
json.is_favorited current_user.favorited_quizzes.include?(quiz)
