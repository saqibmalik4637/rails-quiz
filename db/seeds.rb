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

# duplicate_questions = []
# content_data = {}
# Question.all.each do |question|
#   if content_data.values.include?(question.content)
#     prev_question_id = content_data.key(question.content)

#     prev_question = Question.find(prev_question_id)

#     duplicate_questions << [
#       { question_text: prev_question.content,
#         quiz_name:     prev_question.quiz.name,
#         category_name: prev_question.quiz.category.name },

#       { question_text: question.content,
#         quiz_name:     question.quiz.name,
#         category_name: question.quiz.category.name }
#     ]
#   else
#     content_data[question.id] = question.content
#   end
# end

quiz_names = []

duplicate_questions.each do |arr_item|
  quiz_names << arr_item.last[:quiz_name]
end

new_data = {}
quiz_names.uniq.each do |quiz_name|
  new_data[quiz_name] = quiz_names.count(quiz_name)
end

new_duplicate_data = []
duplicate_questions.each do |arr_item|
  new_duplicate_data << arr_item.last
end

{"Famous Time Travelers"=>15,
 "Alternate Realities"=>1,
 "Time Travel Pop Culture"=>1,
 "Time Travel in Mythology"=>2,
 "Vocabulary Voyager"=>1,
 "Famous Authors"=>1,
 "Word Origins"=>1,
 "English Literature Classics"=>1,
 "Grammar Wizardry"=>1,
 "English Literature Masters"=>2,
 "Language Puzzles"=>1,
 "Traditional Cuisine"=>6,
 "World Religions Trivia"=>1,
 "Cultural Cuisine"=>20,
 "Cricket Rivalries"=>1,
 "Cricket Greats"=>19,
 "Cricket World Rankings"=>1,
 "Historical Figures"=>1,
 "World History Trivia"=>1,
 "Famous Conquerors"=>5,
 "Nature Trivia"=>1,
 "Green Technology"=>1,
 "Celebrities Trivia"=>1,
 "Movie Quotes"=>4,
 "Music Lyrics Challenge"=>7,
 "Music Legends"=>1,
 "Classic Movie Trivia"=>2,
 "Elections and Campaigns"=>1,
 "Political History"=>4,
 "Current Affairs"=>1,
 "Political Figures"=>2,
 "World Politics Trivia"=>4,
 "Political Scandals"=>5,
 "Chemistry Concepts"=>1,
 "Biology Basics"=>1,
 "Astronomy Insights"=>1,
 "Chemical Reactions"=>1,
 "Human Anatomy"=>1,
 "Chemistry Wonders"=>3,
 "Scientific Breakthroughs"=>1,
 "Math and Science"=>2,
 "Movie Awards"=>2,
 "Art History Trivia"=>2,
 "World Capitals"=>3,
 "Continents and Oceans"=>1,
 "Geographical Facts"=>4,
 "Cultural Geography"=>3,
 "World Geography Trivia"=>2,
 "Geography and Environment"=>1,
 "Software World"=>1,
 "Tech History"=>1,
 "Emerging Technologies"=>19,
 "Tech Titans"=>5,
 "Classic Novels"=>1,
 "Literary Classics"=>2,
 "Author Quotes"=>8,
 "Author Trivia"=>5,
 "Culinary Traditions"=>1,
 "Food and Culture"=>12,
 "International Cuisine"=>2,
 "Food Knowledge"=>3,
 "Food and Travel"=>2,
 "Mythology Gods and Goddesses"=>2,
 "Mythology Creatures"=>1,
 "Mythology Epics"=>4,
 "Musical Legends"=>1,
 "Music and Movies"=>2,
 "Music and Technology"=>1,
 "Math Puzzles"=>1,
 "Advanced Math"=>2,
 "Math Trivia"=>4,
 "Math Olympiad"=>1,
 "Math Challenges"=>1,
 "Famous Mathematicians"=>5,
 "Wildlife Facts"=>2,
 "Astronomy Trivia"=>4,
 "Birdwatching"=>1,
 "Marine Life"=>1,
 "Animal Adaptations"=>1,
 "Animal Kingdom Trivia"=>7,
 "Aquatic Life"=>19,
 "Wildlife Conservation"=>1,
 "Basic Astronomy"=>5,
 "Solar System"=>3,
 "Stars and Constellations"=>1,
 "Space Exploration"=>1,
 "Black Holes and Supernovae"=>1,
 "Astronomy Discoveries"=>3,
 "Space Telescopes"=>2}
