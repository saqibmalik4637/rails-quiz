class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user
  protect_from_forgery with: :null_session

  def authenticate_user
    return true
  end
end
