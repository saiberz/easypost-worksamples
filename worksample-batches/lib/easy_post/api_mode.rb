module EasyPost
  class ApiMode
    PRODUCTION = :production
    TEST = :test

    def self.all
      [PRODUCTION, TEST]
    end

    def self.test?(mode)
      mode == TEST
    end

    def self.production?(mode)
      mode == PRODUCTION
    end

  end
end

