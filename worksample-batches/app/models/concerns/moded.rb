module Concerns
  module Moded
    extend ActiveSupport::Concern

    included do
      symbolize :mode, in: EasyPost::ApiMode.all, scopes: true
    end
  end
end

