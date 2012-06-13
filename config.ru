# This file is used by Rack-based servers to start the application.
require 'faye'

#EM.epoll=true

require ::File.expand_path('../config/environment',  __FILE__)

Faye::WebSocket.load_adapter('thin')
Faye::Logging.log_level = :debug
Faye.logger = lambda { |m| Rails.logger.info "Faye logger: #{m}" } 

use Rack::CommonLogger
#use Rack::Static, :urls => ["/css", "/javascript"], :root => "public"

class Filter

  def added(something)
    puts "Faye Filter added."
  end

  def incoming_with_auth(message, callback)

    # Let non-subscribe messages through
    unless message['channel'] == '/meta/subscribe'
      return callback.call(message)
    end

    # Get subscribed channel and auth token
    subscription = message['subscription']
    msg_token    = message['ext'] && message['ext']['authToken']

    # Find the right token for the channel
    registry = JSON.parse(File.read('./tokens.json'))
    token    = registry[subscription]

    # Add an error if the tokens don't match
    if token != msg_token
      message['error'] = 'Invalid subscription auth token'
    end

    # Call the server back now we're done
    puts "Filter incoming: #{message.inspect}"
    callback.call(message)
  end

  def store_statusport_configuration_updates message
    if message['channel'] == '/statusport/read' && message['data']['body']['type'] == 'config_section'
      msg=message['data']['body']['msg']
      section=msg['section']
      values=msg['values']
      values.each_pair do |key,value|
	puts "Gkconfig: { section: #{section.inspect}, key: #{key.inspect}, value: #{value.inspect} }\n"
        Gkconfig.set( section, key, value )
      end
    end
  end

  def store_eventlog message
    if message['channel'] !~ /meta/ && !message['successful']
      puts "EventLog: #{message.inspect}\n"
      message.delete('id') if message['id']
      log_message=message.clone
      if message['channel'] == "/statusport/read" &&
	 message['data']['body']['type'] == 'config_section'
	message['data']['body']['msg']['values'].keys.each do |key|
          new_key=key.gsub(/\./,'%2e')
	  message['data']['body']['msg']['values'][new_key]=message['data']['body']['msg']['values'][key]
	  message['data']['body']['msg']['values'].delete(key)
	end
      end
      EventLog.create log_message
    end
  end

  def incoming(message, callback)
    store_statusport_configuration_updates message
    store_eventlog message

    callback.call(message)
  end

  def outgoing(message, callback)
    #puts "Faye Filter >>> #{message.inspect}" # if message['channel'] !~ /meta/ && !message['successful']
    callback.call(message)
  end
end

#Thread.new do
#  EventMachine.run do
#    EventMachine::connect "localhost", 7000, Follower
#    puts "Connecting"
#  end
#end

#def self.die_gracefully_on_signal
#  Signal.trap("INT")  { EM.stop }
#  Signal.trap("TERM") { EM.stop }
#end

use Faye::RackAdapter, mount: '/faye',
                       timeout: 25,
		       extensions: [Filter.new]
                       #engine:  {
                       #  type: 'redis',
                       #  host: 'localhost',
                       #  port: '6379'
                       #}

run Gnugk::Application

#require 'rainbows'
#require 'unicorn'
#
#rackup = Unicorn::Configurator::RACKUP
#rackup[:port] = 9292
#rackup[:set_listener] = true
#rackup[:options] = {}
#options = rackup[:options]
#options[:config_file] = 'rainbows.conf'
#
#server = Rainbows::HttpServer.new(Gnugk::Application, options)
