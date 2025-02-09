class VerifyQuestionsJob < ApplicationJob
  retry_on Openai::RateLimitError, wait: 10.seconds, attempts: 3

  def perform(question_id:)
    # Fetch question, options, and answer from the database
    question = Question.find(question_id)

    unless question.verified
      Openai::RateLimiter.execute do
        result = call_openai_api(question)
        handle_result(result, question)
      end
    end
  end

  private

  def call_openai_api(question)
    options = question.options
    answer = question.answer

    # Construct question JSON
    question_json = {
      question: question.content,
      options: options.map { |option| { id: option.id, content: option.content } },
      answer: { id: answer.id, content: answer.content }
    }.as_json

    # Construct the prompt for OpenAI
    prompt = <<~PROMPT
      Verify the answer for the following multiple-choice question:
      Question: #{question_json['question']}
      Options:
      #{question_json['options'].map { |option| "#{option['id']}: #{option['content']}" }.join("\n")}
      Answer: #{question_json['answer']['content']}
      
      Respond in JSON format:
      If the answer is correct: { "verified": true, "correct_answer_id": <answer_id> }
      If the answer is incorrect but included in the options: { "verified": false, "correct_answer_id": <correct_answer_id> }
      If the correct answer is not included in the options: { "verified": false, "correct_answer_id": null, "correct_answer": "<correct_answer>" }
    PROMPT

    # Initialize the OpenAI ChatCompletions request
    messages = [
      { role: "system", content: "You are an assistant that verifies answers for multiple-choice questions." },
      { role: "user", content: prompt }
    ]

    chat_completion = Openai::ChatCompletions.new(
      messages: messages,
      model: "gpt-4",
      max_tokens: 150,
      temperature: 0
    )

    # Send the request and handle the response
    chat_completion.request

    response = chat_completion.process

    content = response["choices"][0]["message"]["content"]
    result = JSON.parse(content)

    result
  end

  def handle_result(result, question)
    if result['verified']
      question.update(verified: true)
      Rails.logger.info("Answer for question ##{question.id} is correct.")
    elsif result['correct_answer_id'].present?
      correct_answer_id = result['correct_answer_id']
      correct_option = question.options.find_by(id: correct_answer_id)

      if correct_option
        question.question_answer.update(option_id: correct_option.id)
        question.update(verified: true)
        Rails.logger.info("Updated answer for question ##{question.id} to option ##{correct_answer_id}.")
      else
        question.update(verified: false, verification_error: "Answer is not verified by AI")
      end
    elsif result['correct_answer'].present?
      option = Option.find_or_create_by(content: result['correct_answer'])
      question.question_options.sample.update(option_id: option.id)
      question.question_answer.update(option_id: option.id)
      question.update(verified: true)
    else
      question.update(verified: false, verification_error: "Answer is not verified by AI")
    end
  end
end
