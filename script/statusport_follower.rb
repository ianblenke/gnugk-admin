#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
require 'eventmachine'
gem 'faye'
require 'faye'
require 'faye/protocol/client'

#require 'yaml'
#YAML::ENGINE.yamler = 'syck'

#Faye::Logging.log_level = :debug
#Faye.logger = lambda { |m| puts m }

class Follower < EM::Connection

  def post_init
    File.open( 'config/config.yml' ) { |yf| @sql_config=YAML::load( yf ) }
    EventMachine.add_periodic_timer(1) { send_data "\r\n" }
    @data=""
    @foundversion=false

    @faye_follow_client = Faye::Client.new('http://localhost:9292/faye')

    @faye_follow_client.subscribe '/statusport/write' do |message|
      puts "\n/statusport/write <<< #{message}\n"
      send_data message
    end
  end

  def receive_data data
    @data << data
    if !@foundversion
      if @data =~ /^.*(Version.*)$/m
        @data=$1
	@foundversion=true
      end
    end
    return if @state != :waiting && @state != :startup && @state != :sending_commands && @data !~ /;/

    # We should now have a full statusport "message" to parse
    parse_version if @data =~ /^Version/
    parse_startup if @data =~ /^Startup/
    parse_config_sections if @data =~ /^Config sections/
    parse_section if @data =~ /^Section/
    parse_trace_level if @data =~ /^Trace Level is now /

    send_data "debug trc 0\r\n" if @state == :startup

    reload_config if @state == :started ||
                     @data =~ /^Full Config reloaded./

    dump_section if @state == :have_sections
    send_commands if @state == :sending_commands

    puts "state: #{@state} remaining @data: #{@data.inspect}"
  end

  def reload_config
    if @data =~ /^(Full Config reloaded.)\r\n(.*)$/m
      @data=$2
      msg={ type: :reload,
             msg: { message: $1 } }
      publish_message msg
    end
    @config={}
    @state = :reload_config
    send_data "debug cfg\r\n"
  end

  def dump_section
    return if @state != :have_sections
    if @sections.length == 0
      @state=:waiting
      apply_config
      return
    end
    section=@sections.shift
    send_data "debug cfg #{section}\r\n"
  end

  def parse_trace_level
    if @data =~ /^Trace Level is now (\d+)\r\n(.*)$/m
      @trace_level=$1
      @data=$2
      @state=:started
    end
  end

  def parse_section
    if @data =~ /^Section \[(.*)\]\r\n(.*)\r\n;\r\n(.*)$/m
      section=$1
      @data=$3
      lines=$2.split(/\r\n/)
      values={}
      lines.each do |line|
        (key,value)=line.split(/=/)
        values[key]=value
      end
      @config[section]=values
      msg={ type: :config_section,
             msg: { section: section, lines: lines, values: values } }
      publish_message msg
    end
  end

  def parse_config_sections
    if @data =~ /^Config sections\r\n(.*)\r\n;\r\n(.*)$/m
      @data=$2
      @sections=[]
      $1.split(/\r\n/).each do |section|
        @sections << $1 if section =~ /^\[([^;].*)\]$/
      end
      msg={ type: :config_sections,
             msg: { sections: @sections } }
      publish_message msg
    end
    @state=:have_sections
  end

  def parse_startup
    if @data =~ /^Startup: (.*) +Running: (.*)\r\n;\r\n$/m
      msg={ type: :startup,
             msg: { Startup: $1, Running: $2 } }
      @data=$1 if @data =~ /^;\r\n(.*)$/
      @state = :startup
      publish_message msg
    end
  end

  def parse_version
    message={ type: :version,
	       msg: {} }
    while @data =~ /^(\w+)\(([^\)]+)\) *(.*)$/m
      key=$1
      value=$2
      @data=$3
      if key == 'Ext'
	extra={}
        value.split(/,/).each do |ext|
         (definition,setting) = ext.split(/=/)
         extra[definition]=setting
	end
        message[:msg][key]=extra
      else
        message[:msg][key]=value
      end
    end
    @data=$1 if @data =~ /^\r\n;\r\n(.*)$/m
    publish_message message
  end

  def send_commands
    if @send_commands && ! @send_commands.empty?
      send_data @send_commands.shift
    else
      @state=:waiting
    end
  end

  def apply_config
    @send_commands=[] if ! @send_commands
    puts "\nFINISHME: need to apply a standard working config"
    @sql_config.each_pair do |section, key_value|
      key_value.each_pair do |key, value|
        if ! @config[section] ||
           ! @config[section][key] ||
           @config[section][key].to_s != value.to_s
          @send_commands << "\ndebug set #{section} #{key} #{value}\r\n"
          puts "\ndebug set #{section} #{key} #{value}\r\n"
        end
      end
    end
    if ! @send_commands.empty?
      @state=:sending_commands
    end
  end

  def publish_message msg
    msg[:timestamp]=Time.now.to_i
    puts "\n/statusport/read >>> #{msg}\n"
    @faye_follow_client.publish('/statusport/read', body: msg )
  end

  def unbind
    EM::connect "localhost", 7000, Follower
  end
end

EM::run do
  EM::connect 'localhost', '7000', Follower
end

