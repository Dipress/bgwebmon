#!/usr/bin/env ruby
# coding: utf-8
require "#{File.dirname(__FILE__)}/database.rb"
require 'rubygems'
require 'rrd'

array = []
STDIN.read.scan(/iso.2.3.4.2012.9.2012.*/).each do |a|
  array << a.gsub(/iso.2.3.4.2012.9.2012 /,"").gsub("\"", "")
end

dialuplogin = Dialupip.find_aton(array[0])
if !dialuplogin.nil?
  rx = array[1].to_i
  tx = array[2].to_i
  if rx < dialuplogin.rx
    upload = 0
  else
    upload = ((((rx.to_i - dialuplogin.rx)*8)/60)/1024)
  end
  if tx < dialuplogin.tx
    download = 0
  else
    download = ((((tx.to_i - dialuplogin.tx)*8)/60)/1024)
  end
  if dialuplogin.update_attributes(:rx => rx, :tx => tx, :online => true)
    login = dialuplogin.dialupalias.login_alias
    RRD.update("#{basedir}graphs/#{login}.rrd"), [upload,download])
    puts "обновленно"
  else
    puts "ошибка"
  end
end


#sudo snmptrap -v 2c -c loc localhost "" 1.2.3.4.5.6.7.8 1.2.3.4.2012.9.2012 s "ip" 1.2.3.4.2012.9.2012 s "rx" 1.2.3.4.2012.9.2012 s "tx"
