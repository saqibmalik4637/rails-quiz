require 'jwt'

class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user
  protect_from_forgery with: :null_session

  def authenticate_user
    token = request.headers[:token]
    if token.present?
      decoded_token = JWT.decode token, nil, false
      @current_user = User.find_by(id: decoded_token.first["user_id"])

      if !@current_user.present?
        render json: {}, status: 401
        return
      end
    else
      render json: {}, status: 401
      return
    end
  end
end
