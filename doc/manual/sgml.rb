#!/usr/bin/env ruby
#require 'active_support/core_ext'
#p Hash.from_xml(File.read(ARGV[0]))
require 'rubygems'
gem 'nokogiri'
require 'nokogiri'
ARGV.each do |file|
  document=Nokogiri::XML(File.read(file))
  document.search('sect1').each do |s|
    sect=s.children[0].to_s.split(/[ \n]/)[1]
    puts "[#{sect}]"
    s.children.shift
    s.children.search('item').each do |i|
      puts i.children[1].to_s.split(/\//)[1]
    end
  end
end
