json.quiz do
  json.partial! 'api/v1/quizzes/quiz', quiz: @quiz
end

json.questions @questions, partial: 'api/v1/questions/question', as: :question
