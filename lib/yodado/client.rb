#encoding: utf-8
require 'rest_client'

module Yodado
  class Client

    def do?(feature, state)
      response = RestClient.get(
        Yodado.config.url, 
        {
          :feature => feature, 
          :state => state.merge(request_state)
        }
      )
    end

  private

    def request_state
      state = {}
      if rack_available?
        state = state.merge({
          :session_id => request.session_options[:id],
          :host_name  => request.host,
          :client_ip  => request.remote_ip,
        })
      end
      state
    end

    def request
      Thread.current[:yodado_request]
    end

    def rack_available?
      (defined? Rack) != nil
    end
  end
end