#encoding: utf-8

module Yodado
  class Client

    def initialize
    end

    def do?(feature, state)
      state.merge(request_state)
    end

  private

    def request_state
      if rack_available?
        {
          :session_id => request.session_options[:id],
          :host_name  => request.host,
          :client_ip  => request.remote_ip,
        }
      end
    end

    def request
      Thread.current[:yodado_request]
    end

    def rack_available?
      defined? Rack
    end
  end
end