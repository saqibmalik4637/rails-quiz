class Openai::VerifyQuizJob < ApplicationJob
  def perform(quiz_id:)
    quiz = Quiz.find(quiz_id)
    quiz.questions.in_batches(of: 10).each_with_index do |batch, index|
      # Schedule jobs in batches with a small delay
      batch.each do |question|
        Openai::QuestionAndAnswerVerifyJob.set(wait: index * 5.seconds).perform_later(question_id: question.id)
      end
    end

    quiz.update(verified: true)
  end
end
