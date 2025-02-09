module Deepseek
  class ChatCompletions
    include ApiConnector

    attr_reader :body

    def initialize(
      messages:, model:,
      max_tokens: nil,
      temperature: nil,
      top_p: nil,
      top_k: nil,
      n: nil,
      stop: nil,
      stream: nil,
      presence_penalty: nil,
      frequency_penalty: nil,
      logit_bias: nil,
      user: nil
    )
      @body = {
        messages: messages,
        model: model
      }
      
      # Optional parameters
      @body[:max_tokens] = max_tokens if max_tokens.present?
      @body[:temperature] = temperature if temperature.present?
      @body[:top_p] = top_p if top_p.present?
      @body[:top_k] = top_k if top_k.present?
      @body[:n] = n if n.present?
      @body[:stop] = stop if stop.present?
      @body[:stream] = stream if stream.present?
      @body[:presence_penalty] = presence_penalty if presence_penalty.present?
      @body[:frequency_penalty] = frequency_penalty if frequency_penalty.present?
      @body[:logit_bias] = logit_bias if logit_bias.present?
      @body[:user] = user if user.present?
    end

    def do_request
      post('chat/completions', body)
    end

    def do_process
      request.value!
      # additional data manipulations goes here
    end
  end
end
