module EasyPost
  module Beanstalk
    class Worker < Backburner::Workers::Simple
      cattr_accessor :continue

      def continue_working?
        @@continue.nil? ? @@continue = true : @@continue
      end

      def start
        prepare
        loop do
          continue_working? ? work_one_job : break
        end
      end

    end
  end
end

