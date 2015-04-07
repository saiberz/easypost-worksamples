module EasyPost
  module Job
    class BatchCreate < Base
      queue 'batch-create'
      queue_priority :batch
      describe :batch_id

      def initialize(params, batch_id)
        @params = params
        @batch_id = batch_id
      end

      def batch
        @batch ||= Batch.find(@batch_id)
      end

      def perform
        EasyPost::Interactor::BatchCreate.call(params: @params, batch: batch)
      end

      def success
      end

      def error(exception)
        Rails.logger.error("Failed while creating #{batch} with #{exception.class}" <<
          "#{exception}\n#{exception.backtrace.try(:join, "\n")}")
      end

      def after
      end
    end
  end
end

