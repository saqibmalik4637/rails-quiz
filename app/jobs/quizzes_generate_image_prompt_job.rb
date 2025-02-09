class QuizzesGenerateImagePromptJob < ApplicationJob
  def perform(category_id:)
    category = Category.find(category_id)

    quiz_names = category.quizzes.verified.map{ |quiz| { id: quiz.id, name: quiz.name } }

    user_message = "I am making a quiz app, and I need images for quizzes in various categories.\n"
    user_message += "I already generated images for categories using prompts like:\n"
    user_message += "'Random math equations and symbols, white background, purple, orange, golden colors.'\n"
    user_message += "Now I want to generate image prompts for quizzes in a dreamy style, landscape aspect ratio.\n"
    user_message += "Use different themes and colors for each quiz, like yellow or orange backgrounds.\n"
    user_message += "Generate the prompts in the following JSON format, strictly without any additional text or explanation:\n"
    user_message += "[{\"id\": 1, \"prompt\": \"prompt 1\"}, {\"id\": 2, \"prompt\": \"prompt 2\"}, ...]\n"
    user_message += "Here are the quizzes:\n"
    user_message += quiz_names.to_json

    messages = [
      {
        role: "system",
        content: "You are a helpful assistant."
      },
      {
        role: "user",
        content: user_message
      }
    ]

    # chat_completion = Deepseek::ChatCompletions.new(messages: messages, model: 'deepseek-chat')

    chat_completion = Openai::ChatCompletions.new(messages: messages, model: 'gpt-4')
    chat_completion.request
    response = chat_completion.process

    message_content = response["choices"][0]["message"]["content"]

    splitted_content = message_content.split("```")

    if splitted_content.size > 1
      code_part = splitted_content[1]
    else
      code_part = splitted_content[0]
    end

    prompts_array = JSON.parse(code_part)

    prompts_array.each do |prompt_item|
      quiz = Quiz.find(prompt_item['id'])
      quiz.update(image_generation_prompt: prompt_item['prompt'])
    end
  end
end
