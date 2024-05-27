class QuizzesGenerateImagePromptJob < ApplicationJob
  def perform(category_id:)
    category = Category.find(category_id)

    quiz_names = category.quizzes.map{ |quiz| { id: quiz.id, name: quiz.name } }

    user_message = "I am making a quiz app, I have multiple categories and their respective quizzes\n"
    user_message += "I need images for quizzes\n"
    user_message += "I already generated images for categories from chatgpt using the prompt like ex: for math category 'Random math equations and symbols, white background, purple, orange, golden colors'\n"
    user_message += "I want to generate images with chatgpt for quizzes\n"
    user_message += "Can you please generate prompt for each quiz:\n"
    user_message += quiz_names.to_json
    user_message += "FYI: I need image in dreamy style in landscape aspect ratio\n"
    user_message += "Use some different theme for quizzes like we can change some colors, we can use yellow colors as background or orange color in background\n"
    user_message += "generate prompts like this: Dreamy time travel elements, clocks, hourglasses, and ancient artifacts, white background, yellow and orange accents, landscape aspect ratio in dreamy style\n"
    user_message += "Please generate in json format and include provided quiz id like [{id: 1, prompt: 'prompt 1'}, {id: 2, prompt: 'prompt 2'}, ...]"

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

    chat_completion = Openai::ChatCompletions.new(messages: messages, model: 'gpt-3.5-turbo')
    chat_completion.request
    response = chat_completion.process

    message_content = response["choices"][0]["message"]["content"]

    prompts_array = JSON.parse(message_content.gsub("```", "").gsub("json", "").gsub("\\n", ""))

    prompts_array.each do |prompt_item|
      quiz = Quiz.find(prompt_item['id'])
      quiz.update(image_generation_prompt: prompt_item['prompt'])
    end
  end
end
