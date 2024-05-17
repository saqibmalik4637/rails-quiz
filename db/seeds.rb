JsonData.all.each do |category_name, quizzes_list|
  category = Category.create(name: category_name)

  quizzes_list.each do |quiz_item|
    quiz = category.quizzes.create(name: quiz_item[:name])

    quiz_item[:tags].each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      quiz.tags << tag
    end

    quiz_item[:questions].each do |question_item|
      question = quiz.questions.create(content: question_item[:question_text])
      question_item[:options].each_with_index do |option_text, index|
        option = Option.find_or_create_by(content: option_text)
        question.options << option
        if question_item[:correct_option] == index
          question.answer = option
          question.save!
        end
      end
    end
  end
end

# quiz_names = []

# duplicate_questions.each do |arr_item|
#   quiz_names << arr_item.last[:quiz_name]
# end

# new_data = {}
# quiz_names.uniq.each do |quiz_name|
#   new_data[quiz_name] = quiz_names.count(quiz_name)
# end

# new_duplicate_data = []
# duplicate_questions.each do |arr_item|
#   new_duplicate_data << arr_item.last
# end
