module EasyPost
  module Error
    class Base < StandardError
      attr_accessor :message, :http_status, :code

      def initialize(http_status, code, message)
        @http_status = http_status
        @code        = code
        @message     = message
      end

      alias :to_s :message

      def empty?
        message.to_s.length == 0
      end

      def with(http_status: nil, code: nil, message: nil)
        self.class.new(http_status || self.http_status,
                       code        || self.code,
                       message     || self.message)
      end

      def to_hash
        {code: code, message: message}
      end
    end
  end
end

