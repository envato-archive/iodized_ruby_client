module Yodado
  class Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)
      Thread.current[:yodado_request] = req
      begin
        @app.call(env)
      ensure
        Thread.current[:yoadado_request] = nil
      end
    end
  end
end