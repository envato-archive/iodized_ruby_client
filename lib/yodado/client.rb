#encoding: utf-8

module Yodado
  class Client

    def initialize(host='localhost', port=12345)
      @host = host
      @port = port
    end

    def close
      @transport.close
    end

    def ping()
      thrift_client.ping
    end

    def feature_set(state)
      state = state.merge(request_state)
      thrift_client.feature_set(state)
    end

    private
    def thrift_client
      if @client && @transport && @transport.open?
        @client
      else
        @transport = Thrift::BufferedTransport.new(Thrift::Socket.new(@host, @port))
        @protocol = Thrift::BinaryProtocol.new(@transport)
        @client = Yodado::Features::Client.new(@protocol)

        @transport.open

        @client
      end
    end

    def request_state
      state = {}
      if rack_available? && !request.nil?
        state = state.merge({
          "session_id" => request.session_options[:id] || "",
          "host_name"  => request.host || "",
          "client_ip"  => request.ip || "",
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
