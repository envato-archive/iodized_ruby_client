#encoding: utf-8
require 'iodized/client'
require 'iodized/features'
require 'iodized/middleware'
require 'iodized/version'

module Iodized

  def self.do?(feature, state)
    feature_set = if Thread.current[:iodized_feature_set]
                    Thread.current[:iodized_feature_set]
                  else
                    Thread.current[:iodized_feature_set] = client.feature_set(state)
                  end
    feature_set[feature.to_s] || false
  end

  def self.reset_feature_set!
    Thread.current[:iodized_feature_set] = nil
  end

  def self.client
    @client ||= Iodized::Client.new
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
