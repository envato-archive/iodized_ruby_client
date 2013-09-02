require 'spec_helper'

describe Yodado::Client do

  let(:url) { 'http://dagoba' }
  let(:feature) { :use_the_force_for_knowledge_and_defense }
  let(:request) { double(
    :session_options  => { :id => 'oni2uhroiuq3brlq3jirt' },
    :host             => 'alderan',
    :remote_ip        => 'r2.d2',
  )}

  subject(:yodado) { Yodado::Client.new }
  
  before do
    RestClient.stub(:post)
    Yodado.config.url = url
  end

  context 'yodado server is listening on http://dagoba' do
    let(:endpoint) { 'http://dagoba/use_the_force_for_knowledge_and_defense' }
    
    it 'should send requests to http://dagoba' do
      RestClient.should_receive(:post).with(endpoint, anything)

      yodado.do?(feature, {:username => 'lskywalk'})
    end
  end

  context 'rack is available' do
    let(:state) {{
      :username   => 'lskywalk',
      :session_id => 'oni2uhroiuq3brlq3jirt',
      :host_name  => 'alderan',
      :client_ip  => 'r2.d2',
    }}

    before do
      yodado.stub(:rack_available? => true)
      Thread.stub(:current => {:yodado_request => request})
    end

    it 'should prepopulate the state hash with request values' do
      RestClient.should_receive(:post).with(anything, state)

      yodado.do?(feature, {:username => 'lskywalk'})
    end
  end

  context 'do this, you can' do
    let(:successful_response) { '{"status":true}' }
    
    before do
      RestClient.stub(:post => successful_response)
    end

    it 'should return true' do
      yodado.do?(feature, {:username => 'lskywalk'}).should be_true
    end
  end

  context 'do this, you can not' do
    let(:unsuccessful_response) { '{"status":false}' }
    
    before do
      RestClient.stub(:post => unsuccessful_response)
    end

    it 'should return false' do
      yodado.do?(feature, {:username => 'lskywalk'}).should be_false
    end
  end

  context 'do this, not if anything to say about it i have' do
    let(:gibberish_response) { '{"status":blargh!}' }
    
    before do
      RestClient.stub(:post => gibberish_response)
    end

    it 'should return false' do
      yodado.do?(feature, {:username => 'lskywalk'}).should be_false
    end
  end
end

#describe Yodado::Client do
#  it 'hits dagoba' do
#    Yodado.config.url = 'http://localhost:4567/json'
#    Yodado::Client.new.do?(:feature, {:json => '{"status":true}'})
#  end
#end