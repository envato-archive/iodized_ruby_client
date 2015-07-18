require 'sinatra'
require 'iodized'
require 'json'

Iodized.client = Iodized::Client.new('0.0.0.0', 5353)
use Iodized::Middleware

get '/cool_story' do
  @joe = Iodized.on?(:cool_story_joe, params)
  @features = Thread.current[:iodized_feature_set]
  erb :cool_story
end
