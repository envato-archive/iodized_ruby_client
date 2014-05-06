#encoding: utf-8
require 'yodado/client'
require 'yodado/config'
require 'yodado/features'
require 'yodado/middleware'
require 'yodado/version'

module Yodado

  def self.do?(feature, state)
    feature_set = if Thread.current[:yodado_feature_set]
                    Thread.current[:yodado_feature_set]
                  else
                    Thread.current[:yodado_feature_set] = client.feature_set(state)
                  end
    feature_set[feature.to_s] || false
  end

  def self.reset_feature_set!
    Thread.current[:yodado_feature_set] = nil
  end

  def self.try?(feature, state)
    raise NoMethodError, 'Do or do not; there is no try.'
  end

  def self.client
    @client ||= Yodado::Client.new
  end
  private_class_method :client

  def self.config
    @config ||= Yodado::Config.new
  end

  if defined? Rails
    class YodadoRailtie < Rails::Railtie
      initializer "yodado_railtie.configure_rails_initialization" do |app|
        app.middleware.use Yodado::Middleware
      end
    end
  end
end
