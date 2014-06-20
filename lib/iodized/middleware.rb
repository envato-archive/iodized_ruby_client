#encoding utf-8

module Iodized
  class Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)
      Thread.current[:iodized_request] = req
      begin
        @app.call(env)
      ensure
        Thread.current[:iodized_request] = nil
        Thread.current[:iodized_feature_set] = nil
      end
    end
  end
end
