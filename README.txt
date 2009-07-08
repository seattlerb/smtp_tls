= smtp_tls

* http://seattlerb.rubyforge.org/smtp_tls

== DESCRIPTION:

Provides SMTP STARTTLS support for Ruby 1.8.6 (built-in for 1.8.7+).  Simply
require 'smtp_tls' and use the Net::SMTP#enable_starttls method to talk to
servers that use STARTTLS.

  require 'net/smtp'
  begin
    require 'smtp_tls'
  rescue LoadError
  end
  
  smtp = Net::SMTP.new address, port
  smtp.enable_starttls
  smtp.start Socket.gethostname, user, password, authentication do |server|
    server.send_message message, from, to
  end

You can also test your SMTP connection settings using mail_smtp_tls:

  $ date | ruby -Ilib bin/mail_smtp_tls smtp.example.com submission \
    "your username" "your password" plain \
    from@example.com to@example.com
  Using SMTP_TLS 1.0.3
  -> "220 smtp.example.com ESMTP XXX\r\n"
  <- "EHLO you.example.com\r\n"
  -> "250-smtp.example.com at your service, [192.0.2.1]\r\n"
  -> "250-SIZE 35651584\r\n"
  -> "250-8BITMIME\r\n"
  -> "250-STARTTLS\r\n"
  -> "250-ENHANCEDSTATUSCODES\r\n"
  -> "250 PIPELINING\r\n"
  <- "STARTTLS\r\n"
  -> "220 2.0.0 Ready to start TLS\r\n"
  TLS connection started
  <- "EHLO you.example.com\r\n"
  -> "250-smtp.example.com at your service, [192.0.2.1]\r\n"
  -> "250-SIZE 35651584\r\n"
  -> "250-8BITMIME\r\n"
  -> "250-AUTH LOGIN PLAIN\r\n"
  -> "250-ENHANCEDSTATUSCODES\r\n"
  -> "250 PIPELINING\r\n"
  <- "AUTH PLAIN BASE64_STUFF_HERE\r\n"
  -> "235 2.7.0 Accepted\r\n"
  <- "MAIL FROM:<from@example.com>\r\n"
  -> "250 2.1.0 OK XXX\r\n"
  <- "RCPT TO:<to@example.com>\r\n"
  -> "250 2.1.5 OK XXX\r\n"
  <- "DATA\r\n"
  -> "354  Go ahead XXX\r\n"
  writing message from String
  wrote 91 bytes
  -> "250 2.0.0 OK 1247028988 XXX\r\n"
  <- "QUIT\r\n"
  -> "221 2.0.0 closing connection XXX\r\n"

This will connect to smtp.example.com using the submission port (port 587)
with a username and password of "your username" and "your password" and
authenticate using plain-text auth (the submission port always uses SSL) then
send the current date to to@example.com from from@example.com.

Debug output from the connection will be printed on stderr.

== INSTALL:

  sudo gem install smtp_tls

== LICENSE:

Original code believed public domain from ruby-talk or ruby-core email.

Modifications Copyright (c) 2009 Kyle Maxwell <kyle@kylemaxwell.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
