#!/usr/bin/env ruby
# coding: utf-8

array = []
STDIN.read.scan(/iso.2.3.4.2012.9.2012.*/).each do |a|
  array << a.gsub(/iso.2.3.4.2012.9.2012 /,"").gsub("\"", "")
end

#basedir = File.dirname(__FILE__).gsub(/cronscripts/,"")

ip=array[0].gsub(/\./,"")
cmd="rrdtool fetch /var/www/graphs/#{ip}.rrd AVERAGE -r 300 -s -120"
#cmd="rrdtool fetch #{basedir}graphs/#{ip}.rrd AVERAGE -r 300 -s -120"
rxtx=`#{cmd}`.gsub(/[0-9].+\:.+/).first.gsub(/[0-9]+\:/,"")
#rxtx="-nan -nan -nan -nan"

rxtx.scan(/[0-9]+?\,[0-9]+e\+[0-9][0-9]/).each{|s| array << s}

x = rxtx.split("\ ")

if x[2].to_f.eql? 0.0
  upload=0
  rx=array[1].to_f
else
  lrx=x[2].gsub(/\ /,"").to_f
  rx=array[1].to_f
  (rx<lrx) ? upload=0 : upload=(((rx-lrx)*8)/60)*0.605
end
if x[3].to_f.eql? 0.0
  download=0
  tx=array[2].to_f
else
  ltx=x[3].gsub(/\ /,"").to_f
  tx=array[2].to_f
  (tx<ltx) ? download=0 : download=(((tx-ltx)*8)/60)*0.605
end

cmd = "rrdtool update /var/www/graphs/#{ip}.rrd  N:#{upload.to_i}:#{download.to_i}:#{rx.to_i}:#{tx.to_i}"
#cmd = "rrdtool update #{basedir}graphs/#{ip}.rrd  N:#{upload}:#{download}:#{rx}:#{tx}"
system(cmd)

#File.open('/var/www/trap.log', 'a') do |f|
#  f.puts "graphs/#{ip}.rrd #{Time.now} - N:#{upload.to_i}:#{download.to_i}:#{rx.to_i}:#{tx.to_i}"
#  f.puts "#{rx} - #{lrx} = #{download.to_i}"
#  f.puts "#{tx} - #{ltx} = #{upload.to_i}"
#end
