class QuizzesService
  def self.download_images(ids:)
    wait_time = 1.seconds
    Quiz.where(id: ids).order(id: :asc).each do |quiz|
      next if quiz.id == 1
      DownloadQuizImageJob.set(wait: wait_time).perform_later(quiz_id: quiz.id)
      wait_time += 1.minutes
    end
  end
end
