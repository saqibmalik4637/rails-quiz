module Openai
  class RateLimitError < StandardError
    def initialize(msg = "Rate limit exceeded by OpenAI API")
      super(msg)
    end
  end
end
