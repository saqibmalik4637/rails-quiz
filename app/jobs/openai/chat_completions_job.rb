class Openai::ChatCompletionsJob < ApplicationJob
  def perform(messages:, model:)
    chat_completion = Openai::ChatCompletions.new(messages: messages, model: model)
    chat_completion.request
    chat_completion.process
  end
end
