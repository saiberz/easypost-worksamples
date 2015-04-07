module Concerns
  module Messages
    extend ActiveSupport::Concern

    def append_message(type, message)
      self.messages << {type: type, message: message}
    end
  end
end

