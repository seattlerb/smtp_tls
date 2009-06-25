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
