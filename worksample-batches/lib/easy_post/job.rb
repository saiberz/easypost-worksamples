module EasyPost
  module Job
    extend self

    def pool
      @pool ||= EasyPost::Job::Pool.new()
    end

    def enqueue(item)
      Rails.logger.info("Dispatching #{item.cls} with #{item.args}, #{item.options}.")
      Backburner::Worker.enqueue(item.cls, item.args, item.options)
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

