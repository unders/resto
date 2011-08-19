# encoding: utf-8

$LOAD_PATH << File.dirname(__FILE__) + "../../lib"
require 'resto'


session = Resto.url('https://google.com').verify_none.get
p session.code # => 301
puts "\n"


session = Resto.url('https://encrypted.google.com/').verify_peer.get
p session.code # 200
p session.request
p session.response

puts "\nsession.print:"
puts session.print
