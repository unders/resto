# encoding: utf-8

$LOAD_PATH << File.dirname(__FILE__) + "../../lib"
require 'resto'

msg = "ddddddddd"
# Resto.url('www.google.com').set_debug_output($stderr).get
# Resto.url('www.google.com').set_debug_output($stdout).get
# Resto.url('www.google.com').set_debug_output(msg).get

  # $stderr << msg
  $stderr << "\n"

# puts msg.inspect

puts Resto.url('https://google.com').set_debug_output($stderr).verify_none.get
# puts Resto.url('https://encrypted.google.com/')
#   .set_debug_output($stderr).verify_peer.get
