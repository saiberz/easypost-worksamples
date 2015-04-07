module EasyPost
  module Job
    extend self

    def pool
      @pool ||= EasyPost::Job::Pool.new()
    end

    def enqueue(item)
      EasyPost::Job.pool.delete(item)
      item.cls.perform(*item.args)
    end

    def filter(contoller, &block)
      yield
      pool.flush!
    rescue
      pool.clear
      raise
    end
  end
end

