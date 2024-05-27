require 'jwt'

class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user
  protect_from_forgery with: :null_session

  helper_method :current_user

  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

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

  def current_user
    @current_user
  end
end
