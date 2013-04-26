#!/usr/bin/env ruby
# coding: utf-8

Dir.foreach("/var/spool/sms/failed") do |file_name|
  if file_name != '.' && file_name != '..'
    file_name = "/var/spool/sms/failed/#{file_name}"
    File.open(file_name, "w"){ |f| f.puts IO.readlines(file_name).delete_if{|l| l =~/(Failed|Fail_reason|PDU|Sent)/}.join() }
   `mv #{file_name} #{file_name.gsub(/failed/, 'outgoing')}`
  end
end
