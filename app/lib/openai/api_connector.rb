require 'faraday_connector'

module Openai
  module ApiConnector
    include FaradayConnector
  
    def url
      'https://api.openai.com'
    end
  
    def auth
      "Bearer #{ENV['OPEN_AI_API_KEY']}"
    end
  end
end
