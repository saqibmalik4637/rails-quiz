require 'open-uri'

class DownloadQuizImageJob < ApplicationJob
  def perform(quiz_id:)
    quiz = Quiz.find(quiz_id)
    prompt = "Dreamy, #{quiz.image_generation_prompt}"
    image_generations = Openai::ImageGenerations.new(prompt: prompt, model: 'dall-e-3', n: 1, size: "1792x1024")
    image_generations.request
    response = image_generations.process

    image_url = response["data"][0]["url"]

    file_path = "./app/assets/images/quizzes/#{quiz.name.downcase.gsub(" ", "-").gsub("\(", "").gsub("\)", "")}.png"

    open(file_path, 'wb') do |file|
      file << URI.open(image_url).read
    end
  end
end
