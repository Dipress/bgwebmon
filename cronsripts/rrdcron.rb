#!/usr/bin/env ruby
# coding: utf-8
require "./database.rb"
require "rrd"

class Rrdcron
  def self.datacreator
  		files_array = files_array()
  		Dialupalias.all.each { |a| 
  			if  files_array.find{ |f| f.eql?("#{a.login_alias}.rrd") } == nil
  				add_graph(a.login_alias)
  			end
  		}
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

  def f_n_d?(file_name)
  	(file_name.eql?(".") or file_name.eql?("..")) ? false : true
  end

  def add_graph(login)
  	RRD.create(Rails.root.join('graphs/' + login.to_s + '.rrd'), {:step => 60, 
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

  def files_array
  	array = []
  	Dir.foreach(Rails.root.join('graphs/')) { |f| array << f if f_n_d?(f) }
  	return array
  end
end