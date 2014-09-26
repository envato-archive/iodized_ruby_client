#encoding: utf-8

module Iodized
  class Client

    def initialize(host='localhost', port=5353)
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
      retries = 5
      begin
        features = thrift_client.feature_set(state.merge(request_state))
        if req = Thread.current[:iodized_request]
          # handle session feature value overrides
          Hash[features.map { |feature,value| [feature, req.session[feature].nil? ? value : req.session[feature]] }]
        else
          features
        end

      rescue Thrift::TransportException => e
        if (retries -= 1) > 0
          retry
        else
          raise e
        end
      end
    end

    def override_for_session(feature, feature_value)
      session[feature] = feature_value
    end

    def overriden_for_session?(feature)
      session[feature]
    end

    private

    def session
      if defined? Rails
        if req = Thread.current[:iodized_request]
          req.session
        else
          raise "No request available. Unable to override session"
        end
      else
        raise "This feature requires Rails sessions to operate"
      end
    end

    def thrift_client
      if @client && @transport && @transport.open?
        @client
      else
        @transport = Thrift::BufferedTransport.new(Thrift::Socket.new(@host, @port))
        @protocol = Thrift::BinaryProtocol.new(@transport)
        @client = Iodized::Features::Client.new(@protocol)

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
      Thread.current[:iodized_request]
    end

    def rack_available?
      (defined? Rack) != nil
    end
  end
end
