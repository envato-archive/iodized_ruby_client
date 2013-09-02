require 'spec_helper'

describe Yodado::Client do

  subject(:yodado) { Yodado::Client.new }

  before do
    RestClient.stub(:get)
  end

  context 'yodado server is listening on localhost:12345' do
    let(:url) { 'http://localhost:12345' }

    before do
      Yodado.config.url = url
    end

    it 'should send requests to localhost:12345' do
      RestClient.should_receive(:get).with(url, anything)

      yodado.do?(:feature, {:key => 'value'})
    end
  end

  context 'rack is available' do
    let(:request) { double(
      :session_options  => {:id => 'id'},
      :host             => 'host',
      :remote_ip        => 'ip',
    )}

    let(:state) {{
      :feature => :feature,
      :state => 
      {
        :session_id => 'id',
        :host_name  => 'host',
        :client_ip  => 'ip',
      }
    }}

    before do
      yodado.stub(:rack_available? => true)
      Thread.stub(:current => {:yodado_request => request})
    end

    it 'should prepopulate the state hash with request values' do
      RestClient.should_receive(:get).with(anything, state)

      yodado.do?(:feature, {})
    end
  end
end