module RSpec
  module Rails
    module ControllerExampleGroup
      extend self

      def body
        @body ||= JSON.parse(response.body)
      end

      def api_get(user, route, params = {}, headers = {})
        @body = nil

        request.accept = "application/json"
        params[:api_key] = user.test_api_key
        get route, params, headers

        body
      end

      def api_post(user, route, params = {}, headers = {})
        @body = nil

        request.accept = "application/json"
        params[:api_key] = user.test_api_key
        post route, params, headers

        body
      end

      def api_put(user, route, params = {}, headers = {})
        @body = nil

        request.accept = "application/json"
        params[:api_key] = user.test_api_key
        put route, params, headers

        body
      end
    end
  end
end

