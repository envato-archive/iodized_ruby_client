#encoding: utf-8

module Yodado
  class Config
    attr_accessor :url

    def initialize
      @url = 'http://localhost:12345'
    end
  end
end