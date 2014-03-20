require 'sinatra'
require 'yodado'

use Yodado::Middleware

get '/yodado' do
  @use_the_force = Yodado.do?(:use_the_force, params)
  erb :yodado
end
