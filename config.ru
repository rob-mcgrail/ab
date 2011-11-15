#
# http://rack.rubyforge.org/doc/
#
# http://www.sinatrarb.com/intro#Using%20a%20Classic%20Style%20Application%20with%20a%20config.ru
#
# Starting up the app example:
#
# $ rackup -p 9000 -s mongrel config.ru
#


# Include sinatra now so we can call on settings.

require 'rubygems'
require 'sinatra'
require 'app'

#
# Serve assets locally in development mode; 
# should be served via reverse proxy in 
# production mode.
#
# http://rack.rubyforge.org/doc/classes/Rack/Static.html
#

if settings.development?
  use Rack::Static, :urls => ['/stylesheets', '/javascript', '/log', '/images', 'robots.txt'], :root => "public"
end


run Sinatra::Application
