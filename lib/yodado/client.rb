#encoding: utf-8
require 'rest_client'
require 'json'

module Yodado
  class Client

    def do?(feature, state)
      begin
        response = RestClient.get(url(feature), :params => state.merge(request_state))
        parsed = JSON.parse(response)
        parsed['status'] || false
      rescue
        false
      end
    end

    def force(feature, state)
      do?(feature, state.merge({:forced => true}))
      true
    end

  private
    def request_state
      state = {}
      if rack_available?
        state = state.merge({
          :session_id => request.session_options[:id],
          :host_name  => request.host,
          :client_ip  => request.ip,
        })
      end
      state
    end

    def request
      Thread.current[:yodado_request]
    end

    def url(feature)
      "#{Yodado.config.url}/feature/#{feature}"
    end

    def rack_available?
      (defined? Rack) != nil
    end
  end
end
