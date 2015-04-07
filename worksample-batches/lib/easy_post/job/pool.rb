module EasyPost
  module Job
    class Pool
      extend Forwardable

      def_delegators :pool, :<<, :each, :clear, :delete

      def pool
        @pool ||= []
      end

      def flush!
        each do |item|
          begin
            EasyPost::Job.enqueue(item)
          rescue StandardError => exc
            log_error(exc, item)
          rescue Exception
            clear
            raise
          end
        end

        clear
      end

      def log_error(exc, item)
        backtrace = exc.backtrace.join("\n")
        Rails.logger.error("Failed to queue #{item}, with #{exc}\n#{backtrace}")
      end
    end
  end
end

