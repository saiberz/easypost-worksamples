# For drivers other than Rack::Test, Capybara starts a server on a separate
# thread. The server doesn't share database transactions with the main testing
# thread. Since we use Poltergeist, that means we can't use transactional
# fixtures (at least, not for Capybara tests.)
#
# DatabaseCleaner lets us use transactional fixtures whenever possible and
# fall back to truncation when threads get in the way.
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

