require "rubygems"
require "bundler/setup"
require 'eventmachine'
gem 'faye'
require 'faye'
require 'faye/protocol/client'

#Faye::Logging.log_level = :debug
#Faye.logger = lambda { |m| puts m }

EM.run {
  client = Faye::Client.new('http://localhost:9292/faye')

  client.subscribe '/statusport/read' do |message|
    puts message.inspect
  end
}

