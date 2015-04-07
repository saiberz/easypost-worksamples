# Load database.dev.yml for local database config, or database.yml for remote
module Rails
  class Application
    class Configuration
      def database_configuration
        require 'erb'
        if File.exists?('config/database.dev.yml')
          YAML::load(ERB.new(IO.read('config/database.dev.yml')).result)
        else
          YAML::load(ERB.new(IO.read('config/database.yml')).result)
        end
      end
    end
  end
end

