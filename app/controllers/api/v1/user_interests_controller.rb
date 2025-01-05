class Api::V1::UserInterestsController < Api::V1::BaseController
  def create
    if params[:interests_ids].present?
      params[:interests_ids].each do |interest_id|
        current_user.user_interests.create(interest_id: interest_id)
      end
    end
  end
end
