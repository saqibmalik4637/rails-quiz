class CategoriesService
  def self.attach_images
    Category.all.each do |category|
      filename = category.name.downcase.gsub(" ", "-").gsub("\(", "").gsub("\)", "")
      file = File.open("./app/assets/images/categories/#{filename}.png")
      category.image.attach(io: file, filename: filename)
    end
  end

  def self.generate_quizzes_image_prompts
    wait_time = 1.seconds
    Category.all.each do |category|
      next if category.id == 1
      QuizzesGenerateImagePromptJob.set(wait: wait_time).perform_later(category_id: category.id)
      wait_time += 10.seconds
    end
  end
end
