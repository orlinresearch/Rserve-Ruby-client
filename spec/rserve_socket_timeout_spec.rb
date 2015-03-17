require File.expand_path("#{File.dirname(__FILE__)}/spec_helper.rb")
require 'socket'

describe 'Rserve socket timeout' do
  before do
    @r = Rserve::Connection.new timeout: 1
  end

  describe 'with clients timeout major than servers timeout' do
    it 'should raise a SocketTimeoutError exception' do
      expect { @r.eval('Sys.sleep(2)') }.to raise_error(Rserve::Talk::SocketTimeoutError)
    end
  end

  describe 'with clients timeout minor than servers timeout' do
    it 'should work ok' do
      @r.eval('a <- "apple"').to_ruby.should == 'apple'
    end
  end
end