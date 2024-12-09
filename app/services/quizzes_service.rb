class QuizzesService
  def self.download_images(ids:)
    wait_time = 1.seconds
    Quiz.where(id: ids).order(id: :asc).each do |quiz|
      next if quiz.id == 1
      DownloadQuizImageJob.set(wait: wait_time).perform_later(quiz_id: quiz.id)
      wait_time += 20.seconds
    end
  end

  def self.attach_images(ids:)
    Quiz.where(id: ids).order(id: :asc).each do |quiz|
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

  def self.verify_selected_quizzes
    beginner_tag = Tag.find_by(name: 'beginner')
    intermediate_tag = Tag.find_by(name: 'intermediate')
    advanced_tag = Tag.find_by(name: 'advanced')

    Category.all.each_with_index do |category, index|
      Openai::VerifyQuizJob.set(wait: index * 1.minute).perform_later(quiz_id: category.quizzes.joins(:tags).where(verified: false, tags: { name: [beginner_tag.name] }).first.id)
      Openai::VerifyQuizJob.set(wait: (index + 1) * 1.minute).perform_later(quiz_id: category.quizzes.joins(:tags).where(verified: false, tags: { name: [intermediate_tag.name] }).first.id)
      Openai::VerifyQuizJob.set(wait: (index + 2) * 1.minute).perform_later(quiz_id: category.quizzes.joins(:tags).where(verified: false, tags: { name: [advanced_tag.name] }).first.id)
    end
  end
end
