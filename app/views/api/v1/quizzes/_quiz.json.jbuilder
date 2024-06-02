json.(
  quiz,
  :id,
  :name,
  :description,
  :image_url,
  :total_points,
  :questions_count,
  :tags_json,
  :tags_string,
  :played_count,
  :favorited_count,
  :shared_count
)

json.is_favorited current_user.favorited_quizzes.include?(quiz)
