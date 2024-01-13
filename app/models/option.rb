class Option < ApplicationRecord
  # INSTANCE METHODS
  def as_json
    {
      "id": id,
      "content": content
    }
  end
end
