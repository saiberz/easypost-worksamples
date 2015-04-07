module Concerns
  module PublicID
    extend ActiveSupport::Concern

    included do
      after_initialize :assign_public_id
    end

    def self.public_id_prefix
      raise NotImplementedError
    end

    def assign_public_id
      unless self.public_id.present?
        self.public_id = EasyPost::PublicIDGenerator.generate_uuid(self.class.public_id_prefix)
      end
    end
  end
end

