require 'faraday_connector'

module Openai
  module ApiConnector
    include FaradayConnector
  
    def url
      'https://api.openai.com'
    end
  
    def auth
      "Bearer sk-proj-anOtk68TzDJmaIoePzcQT3BlbkFJpIfciNNK3s8CqWaLxw9W"
    end
  end
end
