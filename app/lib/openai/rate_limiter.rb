module Openai
  class RateLimiter
    MAX_REQUESTS_PER_MINUTE = 60 # Adjust per your OpenAI account
    MUTEX = Mutex.new

    @request_count = 0
    @last_reset = Time.now

    def self.execute
      MUTEX.synchronize do
        reset_limit_if_needed
        if @request_count >= MAX_REQUESTS_PER_MINUTE
          sleep(1) # Wait a short time to avoid hitting limits
        else
          @request_count += 1
          yield
        end
      end
    end

    def self.reset_limit_if_needed
      if Time.now - @last_reset > 60
        @request_count = 0
        @last_reset = Time.now
      end
    end
  end
end
