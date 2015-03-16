require File.expand_path("#{File.dirname(__FILE__)}/spec_helper.rb")
require 'socket'

describe 'Rserve socket tieout' do
  before do
    @r = Rserve::Connection.new

    # we run a simple TCP server
    # delay = 5
    # server = TCPServer.new 2000

    # loop do
    #   client = server.accept
    #   puts "#{Time.now} > Client arrived. Sleeping for #{delay}s."
    #   sleep delay
    #   puts "#{Time.now} > Done, replying."
    #   client.puts "Done. Bye!"
    #   client.close
    # end
  end

  describe 'with clients timeout major than servers timeout' do
    it 'should work timeout the socket' do
      # we run a simple TCP client with IO.select
      host = '127.0.0.1'
      port = 2000
      timeout = 2

      s = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
      s.connect(Socket.pack_sockaddr_in(port, host))

      rs, = IO.select([s], [], [], timeout)

      result = if rs
        rs[0].read(1000)
      else
        'Timeout'
      end

      s.close

      result.should == 'Timeout'
    end
  end
end