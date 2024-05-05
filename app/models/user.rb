require 'jwt'

class User < ApplicationRecord

  def jwt_token
    payload = { user_id: id }
    token = JWT.encode payload, nil, 'none'
  end
end
