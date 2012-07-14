#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
require 'eventmachine'

gem 'faye'
require 'faye'
require 'faye/protocol/client'

#Faye::Logging.log_level = :debug
#Faye.logger = lambda { |m| puts m }

module DebugTraceFollower
  def post_init
    @faye_debug_trace_client ||= Faye::Client.new('http://localhost:9292/faye')
    @buffer=""
    @lines=[]
    @message=[]
  end
  def receive_data data
    @buffer << data
    while @buffer =~ /^([^\n]+)\n(.*)$/m
      @lines.push $1
      @buffer=$2
    end
    while ! @lines.empty?
      line=@lines.shift
      if line =~ /^\d\d\d\d/
        if @message.size > 0
          fields=@message.shift.split(/\t/)
	  event = {}
          ['date','number','line','module','message'].each do |field|
            value=fields.shift
	    value="" if ! value
            event[field]=value.lstrip.rstrip
          end
          event['message'] << @message.join("\n")
	  if event['message'].empty?
	    event['message']=event['module']
	    event.delete('module')
	  end
          puts "\nevent=#{event.inspect}\n"
          @faye_debug_trace_client.publish('/debug/trace', body: event)
          @message=[]
        end
        if @lines.size == 1
          @lines.unshift line
	  break
	end
      end
      @message.push line
    end
  end
  def unbind
    @faye_debug_trace_client.publish('/debug/trace', status: get_status.exitstatus )
  end
end

EM::run do
  EM.popen("bash -c 'gdb -ex run --args gnugk -c gnugk.ini 2>&1'", DebugTraceFollower)
end

