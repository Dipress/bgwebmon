#!/usr/bin/env ruby
# coding: utf-8

require 'rubygems'
require 'active_record'
require 'yaml'

basedir = File.dirname(__FILE__).gsub(/cronscripts/,"")
yaml = YAML.load_file("#{basedir}config/database.yml")['production']
Dir["#{basedir}app/models/*.rb"].each {|file| 
  if !file.eql?("/var/www/webmon/current/app/models/tfile.rb") && !file.eql?('/var/www/webmon/current/app/models/agent_payment.rb')
    require file
  end
}

ActiveRecord::Base.establish_connection(
  :adapter  => "#{yaml['adapter']}",
  :host     => "#{yaml['host']}",
  :username => "#{yaml['username']}",
  :password => "#{yaml['password']}",
  :database => "#{yaml['database']}"
)
