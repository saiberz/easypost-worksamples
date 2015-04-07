module EasyPost
  module Job
    PoolItem = Struct.new(:cls, :args, :options)

    class Base
      include Backburner::Queue

      def self.pool(*args, options: {})
        EasyPost::Job.pool << PoolItem.new(self, args, options)
      end

      def self.perform(*args)
        new(*args).work
      end

      def work
        begin
          hook :before
          perform
          hook :success
        rescue Exception => exc
          hook :error, exc
          EasyPost::Job.pool.clear
          raise exc
        ensure
          hook :after
        end

        EasyPost::Job.pool.flush!
      end

    end
  end
end

