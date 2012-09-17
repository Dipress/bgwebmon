#!/usr/bin/env ruby
# coding: utf-8
require "#{File.dirname(__FILE__)}/database.rb"
require "rrd"

class Rrdcron
  def self.datacreator
  		files_array = files_array()
  		Dialupalias.all.each { |a| 
  			if  files_array.find{ |f| f.eql?("#{a.login_alias.downcase}.rrd") } == nil
  				Rrdcron.add_graph(a.login_alias.downcase)
  			end
  		}
      system('chmod 777 #{Rrdcron.dir_name}graphs/*.rrd')
  end

  def self.test
    x = self.dir_name
    puts "#{x}"
  end

  def self.checkonline
    Dialupalias.all.each{ |a|
      check = `rrdtool fetch /var/www/bgwebmon/graphs/#{a.login_alias}.rrd AVERAGE -s -60 -e -60`
      if check =~ /-nan/
        d = a.dialuplogin
        d.update_attribute(:online, 0)
      end
    }
  end

private

  def self.dir_name
    File.dirname(__FILE__).gsub(/cronscripts/,"")
  end

  def self.add_graph(login)
  	RRD.create("#{Rrdcron.dir_name}graphs/#{login.to_s}.rrd", {:step => 60, 
  							:heartbeat => 120, 
  							:ds => [{:name => "upload", 
  									 :type => "GAUGE"},
  						   {:name => "download", 
  						   	:type => "GAUGE"}],
  						   :xff => ".5",
  						   :rra => [{:type => "average", 
  						   	         :steps => 1, 
  						   	         :rows => 20160}]})
  end

  def self.files_array
  	array = []
  	Dir.foreach("#{Rrdcron.dir_name}graphs/") { |f| array << f }
  	return array
  end
end