class Api::V1::InterestsController < Api::V1::BaseController
  skip_before_action :authenticate_user, only: [:index]

  def index
    @interests = Interest.all
  end
end
