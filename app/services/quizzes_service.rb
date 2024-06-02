class QuizzesService
  def self.download_images(ids:)
    wait_time = 1.seconds
    Quiz.where(id: ids).order(id: :asc).each do |quiz|
      next if quiz.id == 1
      DownloadQuizImageJob.set(wait: wait_time).perform_later(quiz_id: quiz.id)
      wait_time += 1.minutes
    end
  end

  def self.attach_images
    Category.first.quizzes.each do |quiz|
      filename = quiz.name.downcase.gsub(" ", "-").gsub("\(", "").gsub("\)", "")
      file = File.open("./app/assets/images/quizzes/#{filename}.png")
      quiz.image.attach(io: file, filename: filename)
    end
  end

  def self.add_description
    JsonData.quiz_descriptions.each do |quiz_item|
      quiz = Quiz.find(quiz_item[:id])
      quiz.update(description: quiz_item[:description])
    end
  end
end
