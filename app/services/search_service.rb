class SearchService
  attr_reader :query, :keywords

  def initialize(query:)
    @query = query.downcase.gsub("'", "")

    temp_keywords = @query.split(" ")
    @keywords     = []

    while temp_keywords.length > 1
      @keywords << temp_keywords.join(" ")
      temp_keywords.pop
    end

    @keywords += @query.split(" ")
  end

  def suggestions
    quiz_names = Quiz.verified.where((["LOWER(translate(name, '-_""\''', '')) LIKE ?"] * @keywords.size).join(' OR '), *@keywords.map{ |key| "%#{key}%" }).pluck(:name)
    sorted_quiz_names = sort_by_keywords(quiz_names)

    category_names = Category.where((["LOWER(translate(name, '-_""\''', '')) LIKE ?"] * @keywords.size).join(' OR '), *@keywords.map{ |key| "%#{key}%" }).pluck(:name)
    sorted_category_names = sort_by_keywords(category_names)

    sorted_quiz_names + sorted_category_names
  end

  def quizzes
    result = Quiz.search(query).to_a

    keywords.each do |keyword|
      result += Quiz.search(keyword)
    end

    result
  end

  def categories
    Category.search(query)
  end

  private

  def sort_by_keywords(item_names)
    sorted_names = item_names.map do |item_name|
      matched_percentage = 0
      temperature = keywords.size
      keywords.each do |keyword|
        item_name = item_name.downcase.gsub("'", "")
        longer = [keyword.size, item_name.size].max
        same = keyword.each_char.zip(item_name.each_char).count { |a, b| a == b }
        matched_percentage += (same / longer.to_f) * temperature
        temperature -= 1
      end

      [item_name, matched_percentage]
    end.sort_by { |item| item[1]  }.reverse.map { |item| item[0] }
  end
end
