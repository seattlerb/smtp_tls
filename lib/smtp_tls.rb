
require 'openssl'
require 'net/smtp'

# :stopdoc:

class Net::SMTP

  class SMTP_TLS
    VERSION = '1.0'
  end

  class << self
    send :remove_method, :start
  end

  def self.start(address, port = nil, helo = 'localhost.localdomain',
                 user = nil, secret = nil, authtype = nil, use_tls = false,
                 &block) # :yield: smtp
    new(address, port).start(helo, user, secret, authtype, use_tls, &block)
  end

  alias tls_old_start start

  def start(helo = 'localhost.localdomain',
            user = nil, secret = nil, authtype = nil, use_tls = false) # :yield: smtp
    start_method = use_tls ? :do_tls_start : :do_start
    if block_given?
      begin
        send start_method, helo, user, secret, authtype
        return yield(self)
      ensure
        do_finish
      end
    else
      send start_method, helo, user, secret, authtype
      return self
    end
  end

  private

  def do_tls_start(helodomain, user, secret, authtype)
    raise IOError, 'SMTP session already started' if @started
    check_auth_args user, secret, authtype if user or secret

    sock = timeout(@open_timeout) { TCPSocket.open @address, @port }
    @socket = Net::InternetMessageIO.new(sock)
    @socket.read_timeout = 60 # @read_timeout

    check_response(critical { recv_response() })
    do_helo helodomain

    raise 'openssl library not installed' unless defined?(OpenSSL)
    starttls
    ssl = OpenSSL::SSL::SSLSocket.new sock
    ssl.sync_close = true
    ssl.connect
    @socket = Net::InternetMessageIO.new ssl
    @socket.read_timeout = 60 # @read_timeout
    do_helo helodomain

    authenticate user, secret, authtype if user
    @started = true
  ensure
    unless @started then
      # authentication failed, cancel connection.
      @socket.close if not @started and @socket and not @socket.closed?
      @socket = nil
    end
  end

  def do_helo(helodomain)
     begin
      if @esmtp then
        ehlo helodomain
      else
        helo helodomain
      end
    rescue Net::ProtocolError
      if @esmtp then
        @esmtp = false
        @error_occured = false
        retry
      end
      raise
    end
  end

  def starttls
    getok 'STARTTLS'
  end

  alias tls_old_quit quit # :nodoc:

  def quit
    begin
      getok 'QUIT'
    rescue EOFError
    end
  end

end unless Net::SMTP.private_method_defined? :starttls

