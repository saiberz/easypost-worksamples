require 'uri'

module URI
  class Generic
    def hostname_with_port
      if port == default_port
        hostname
      else
        "#{hostname}:#{port}"
      end
    end
  end
end

