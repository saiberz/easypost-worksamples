require 'backburner'

Backburner.configure do |config|
  config.beanstalk_url    = ENV['BEANSTALK_URL'] || "beanstalk://localhost:11300"
  config.tube_namespace   = "easypost"
  config.max_job_retries  = 3
  config.respond_timeout  = 1200
  config.default_priority = 42
  config.default_worker   = EasyPost::Beanstalk::Worker
  config.logger           = Rails.logger
  config.priority_labels  = {tracker: 3, event: 2, batch: 1}
  config.reserve_timeout  = 5
end

