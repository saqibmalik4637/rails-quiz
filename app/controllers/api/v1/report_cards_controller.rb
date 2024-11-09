class Api::V1::ReportCardsController < Api::V1::BaseController
  def show
    @report_card = ReportCard.find(params[:id])
  end

  def create
    @report_card = ReportCard.create(report_card_params)
  end

  private

  def report_card_params
    params.require(:report_card).permit(
      :user_id,
      :quiz_id,
      :room_id,
      given_answers: [
        :result,
        :points,
        :time_taken,
        :allowed_time,
        question: [:id, :content],
        user_answer: [:id, :content],
        correct_answer: [:id, :content]
      ]
    )
  end
end
