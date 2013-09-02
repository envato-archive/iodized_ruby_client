#encoding: utf-8
require 'yodado/version'
require 'yodado/client'
require 'yodado/middleware'

module Yodado

  def self.do?(feature, state)
    client.do?(feature, state)
  end

  def self.try?(feature, state)
    raise NoMethodError, 'Do or do not; there is no try.'
  end

  def self.force(feature)
    client.force(feature)
  end

  def self.client
    @client ||= Yodado::Client.new
  end

  def self.config
    @config ||= Yodado::Config.new
  end
end