module Concerns
  module UserOwnable
    extend ActiveSupport::Concern

    included do
      belongs_to :user
      validates :user, presence: true
    end
  end
end

