class Api::V1::QuestionsController < Api::V1::BaseController
  def index
    @quiz = Quiz.find(params[:quiz_id])
    limit_val = params[:limit].to_i

    @questions = fetch_questions(1, limit_val)
    @questions = fetch_questions(2, limit_val) if @questions.size < limit_val
    @questions = fetch_questions(3, limit_val) if @questions.size < limit_val
    @questions = fetch_questions(4, limit_val) if @questions.size < limit_val
  end

  private

  def fetch_questions(level, limit_val)
    base_scope = @quiz.questions.includes(:options, :answer)
    country_condition = "questions.preferred_countries @> ? OR questions.preferred_countries = '[]'::jsonb"
    country_val = [current_user.country_code].to_json

    case level
    when 1
      # Filter by country, age and exclude played questions.
      base_scope.where(country_condition, country_val)
                .where('questions.preferred_min_age IS NULL OR (questions.preferred_min_age <= ? AND questions.preferred_max_age >= ?)', current_user.age, current_user.age)
                .where.not(id: current_user.played_question_ids)
                .order("RANDOM()")
                .limit(limit_val)
    when 2
      # Filter by country and age.
      base_scope.where(country_condition, country_val)
                .where('questions.preferred_min_age IS NULL OR (questions.preferred_min_age <= ? AND questions.preferred_max_age >= ?)', current_user.age, current_user.age)
                .order("RANDOM()")
                .limit(limit_val)
    when 3
      # Filter by country only.
      base_scope.where(country_condition, country_val)
                .order("RANDOM()")
                .limit(limit_val)
    when 4
      # Fallback: random order.
      base_scope.order("RANDOM()").limit(limit_val)
    end
  end
end
