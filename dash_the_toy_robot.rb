# Dependencies
# 1. colorize gem - gem install colorize

require 'colorize'

require './world'
require './🤖'
require './game'

case ARGV[0].to_s.upcase == "TEST"
when true   
  require './test'
  Test.new 
when false then Game.new
end
  


#