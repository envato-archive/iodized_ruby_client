require 'spec_helper'

describe Yodado::Client do

  let(:url) { 'http://dagoba' }
  let(:feature) { :use_the_Force_for_knowledge_and_defense }
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

  context 'yodado server is listening on localhost:12345' do

    it 'should send requests to localhost:12345' do
      RestClient.should_receive(:post).with('http://dagoba/use_the_Force_for_knowledge_and_defense', anything)

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
end