namespace :beanstalk do
  task :work, [:tubes] => :environment do |t, args|
    job_classes = [
      EasyPost::Job::BatchCreate,
    ]
    queues = job_classes.map { |cls| cls.queue }

    tubes = args[:tubes].nil? ? queues : args[:tubes].split

    tubes.each do |tube|
      unless queues.include? tube
        raise StandardError, "Invalid tube: #{tube}"
      end
    end

    Backburner.work(tubes)
  end
end

