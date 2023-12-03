# Dependencies
# 1. colorize gem - gem install colorize

require 'colorize'

require './world'
require './🤖'
require './game'
require './test'


case ARGV[0].to_s.upcase == "TEST"
when true  then Test.new 
when false then Game.new
end
  


#