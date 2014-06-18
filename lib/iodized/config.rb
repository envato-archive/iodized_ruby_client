#encoding: utf-8

module Iodized
  class Config
    attr_accessor :url

    def initialize
      @url = 'http://localhost:8080'
    end
  end
end
