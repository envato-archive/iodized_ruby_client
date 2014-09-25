#encoding: utf-8
require 'iodized/client'
require 'iodized/features'
require 'iodized/middleware'
require 'iodized/version'

module Iodized

  def self.on?(feature, state)
    feature_set(state)[feature.to_s] || false
  end

  def self.feature_set(state)
    Thread.current[:iodized_feature_set] ||= client.feature_set(state)
  end

  def self.reset_feature_set!
    Thread.current[:iodized_feature_set] = nil
  end

  def self.client
    @client ||= Iodized::Client.new
  end

  def self.override_for_session(feature, feature_value)
    client.override_for_session(feature, feature_value)
  end

  def self.overriden_for_session?(feature)
    client.overriden_for_session?(feature)
  end

  def self.client=(client)
    @client = client
  end

  def self.config(host, port)
    self.client = Iodized::Client.new(host, port)
  end

  if defined? Rails
    class IodizedRailtie < Rails::Railtie
      initializer "iodized_railtie.configure_rails_initialization" do |app|
        app.middleware.use Iodized::Middleware
      end
    end
  end
end
