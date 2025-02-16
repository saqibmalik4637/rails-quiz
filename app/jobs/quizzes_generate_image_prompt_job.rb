class QuizzesGenerateImagePromptJob < ApplicationJob
  queue_as :default

  def perform(category_id:)
    category = Category.find(category_id)

    Quiz.where(image_generation_prompt: nil).find_in_batches(batch_size: 80) do |batch|
      quiz_names = batch.map { |quiz| { id: quiz.id, name: quiz.name } }

      user_message = <<~MSG
        I am making a quiz app and need creative image prompts for quizzes in various categories.
        
        - I previously generated category images using prompts like:
          "Random math equations and symbols, white background, purple, orange, golden colors."
        
        - Now, I need **unique** image generation prompts for each quiz.
        - The prompts should be **dreamy-style, colorful, and landscape aspect ratio**.
        - Each quiz should have **varied themes and colors** (e.g., yellow, orange, blue, green).
        - Ensure **no repetition** in style across quizzes.

        **Return JSON in this format:**  
        ```json
        [{"id": 1, "prompt": "Dreamy illustration of ..."}, {"id": 2, "prompt": "Futuristic neon ..."}]
        ```

        **Quizzes:**  
        #{quiz_names.to_json}
      MSG

      messages = [
        { role: "system", content: "You are an expert in generating creative image prompts for AI image models." },
        { role: "user", content: user_message }
      ]

      chat_completion = Openai::ChatCompletions.new(messages: messages, model: 'gpt-4-turbo')
      chat_completion.request
      response = chat_completion.process

      message_content = response.dig("choices", 0, "message", "content") || ""

      # Extract JSON content
      code_part = message_content.split("```").find { |block| block.include?("[{") }&.gsub('json', '')&.strip

      begin
        prompts_array = JSON.parse(code_part)
      rescue JSON::ParserError => e
        Rails.logger.error "JSON parsing error in QuizzesGenerateImagePromptJob: #{e.message}"
        next
      end

      # Update quizzes with generated prompts
      prompts_array.each do |prompt_item|
        quiz = Quiz.find_by(id: prompt_item['id'])
        quiz.update(image_generation_prompt: prompt_item['prompt']) if quiz
      end
    end
  end
end
