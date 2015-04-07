module EasyPost
  module PublicIDGenerator
    def self.generate_uuid(prefix)
      prefix + "_" + SecureRandom.uuid.gsub("-", "")
    end
  end
end

