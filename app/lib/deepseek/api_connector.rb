require 'faraday_connector'

module Deepseek
  module ApiConnector
    include FaradayConnector
  
    def url
      'https://api.deepseek.com'
    end
  
    def auth
      "Bearer sk-3f5ee629b182458db47b092f3f8855b9"
    end
  end
end
