#encoding: utf-8

module Yodado
  class Config
    attr_accessor :url

    def initialize
      @url = 'http://dagoba.system:12345'
    end
  end
end