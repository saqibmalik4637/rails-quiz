json.(
	room,
	:id,
	:user_id,
	:quiz_id,
	:quiz_image,
	:quiz_name,
	:joining_code,
	:status,
	:users
)

json.quiz do
	json.partial! 'api/v1/quizzes/quiz', quiz: room.quiz
end
