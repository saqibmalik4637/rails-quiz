class SetQuizPreferencesJob < ApplicationJob
  def perform(quiz_id:)
    quiz = Quiz.find(quiz_id)
    
    # Prepare the data to send to OpenAI
    questions_data = quiz.questions.select(:id, :content).to_json
    interests_data = Interest.select(:id, :name).to_json

    # This is the expected response format for the AI
    response_format = {
      quiz_preferred_countries: ['US', 'IN'],
      quiz_preferred_min_age: 15,
      quiz_preferred_max_age: 25,
      quiz_preferred_interest_ids: [1, 2, 3],
      questions: [
        {
          id: 1,
          preferred_countries: ['IN'],
          preferred_min_age: 16,
          preferred_max_age: 23
        }
      ]
    }.to_json

    # Compose the message to instruct the AI what to do
    user_message = <<~MSG
      I am giving you a quiz and its questions. I need to add preferences for the quiz and its questions.
      I need to add preferred_countries, preferred_min_age, and preferred_max_age to both the quiz and its questions.
      I also need to associate quizzes with user interests.
      
      Here is the quiz name: #{quiz.name}
      
      Here is the quiz description: #{quiz.description}
      
      Here is all questions JSON data: #{questions_data}
      
      Here is all interests JSON data: #{interests_data}
      
      Here is the expected JSON response format: #{response_format}
      
      Important note: Generate preferred_countries and preferred_age for quizzes only when really needed; otherwise, leave those preferences blank because a quiz might be global.
      However, its questions may be different for different age groups and different countries.
      Also, make sure to generate quiz_preferred_interest_ids for quizzes from the provided interests data because each quiz should be associated with at least one interest (more than one is ok).
      
      Strict note: Your response MUST be a valid JSON object enclosed in triple backticks.
      Do not include any explanation, commentary, or additional keys.
      Also, do not include any question content in the response.
    MSG

    messages = [
      {
        role: "system",
        content: "You are a helpful assistant that generates preferences for quizzes and their questions based on countries, user interests, and user age."
      },
      {
        role: "user",
        content: user_message
      }
    ]

    # Call OpenAI's ChatCompletions API (assumes you have an Openai::ChatCompletions class set up)
    chat_completion = Openai::ChatCompletions.new(messages: messages, model: 'gpt-4')
    chat_completion.request
    response = chat_completion.process

    message_content = response["choices"][0]["message"]["content"]

    # Extract the JSON code block (content between triple backticks)
    splitted_content = message_content.split("```")
    code_part = splitted_content.size > 1 ? splitted_content[1] : splitted_content[0]
    code_part.strip!

    # Parse the JSON response from the AI
    begin
      quiz_data = JSON.parse(code_part)
    rescue JSON::ParserError => e
      Rails.logger.error "JSON parsing error in SetQuizPreferencesJob: #{e.message}"
      return
    end

    # Update the quiz with any provided preferences.
    # We update preferred_countries, preferred_min_age, preferred_max_age, and preferred_interest_ids if they are present.
    quiz_attributes = {}
    quiz_attributes[:preferred_countries] = quiz_data['quiz_preferred_countries'] if quiz_data['quiz_preferred_countries'].present?
    quiz_attributes[:preferred_min_age] = quiz_data['quiz_preferred_min_age'] if quiz_data['quiz_preferred_min_age'].present?
    quiz_attributes[:preferred_max_age] = quiz_data['quiz_preferred_max_age'] if quiz_data['quiz_preferred_max_age'].present?
    quiz_attributes[:interest_ids] = quiz_data['quiz_preferred_interest_ids'] if quiz_data['quiz_preferred_interest_ids'].present?

    quiz.update(quiz_attributes) if quiz_attributes.present?

    # Update each question's preferences (if provided)
    if quiz_data['questions'].present?
      quiz_data['questions'].each do |question_data|
        question = quiz.questions.find_by(id: question_data['id'])
        next unless question

        question_attributes = {}
        question_attributes[:preferred_countries] = question_data['preferred_countries'] if question_data['preferred_countries'].present?
        question_attributes[:preferred_min_age] = question_data['preferred_min_age'] if question_data['preferred_min_age'].present?
        question_attributes[:preferred_max_age] = question_data['preferred_max_age'] if question_data['preferred_max_age'].present?
        question.update(question_attributes) if question_attributes.present?
      end
    end
  end
end
