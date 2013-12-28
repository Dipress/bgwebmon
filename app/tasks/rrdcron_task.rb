# coding: utf-8
require "rrd"
class RrdcronTasks
  def self.datacreator
    files_array = files_array()
    Dialupip.all.each do |dl| 
      dlip = Dialupip.ntoa(dl.ip)
      if files_array.find{ |f| f.eql?("#{dlip.gsub(/\./,"")}.rrd") } == nil
        RrdcronTasks.add_graph(dlip.gsub(/\./,""))
      end
    end
    InetServices.all.each do |inet|
      inet.inet_resource_subscriptions.each do |s|
        ip = s.addressFrom.bytes.to_a.join('.')
        if files_array.find{ |f| f.eql?("#{dlip.gsub(/\./,"")}.rrd") } == nil
          RrdcronTasks.add_graph(ip.gsub(/\./,""))
        end
      end
    end
  end

  def self.test
    x = self.dir_name
    puts "#{x}"
  end

private

  def self.add_graph(login)
  	RRD.create("/var/www/graphs/#{login.to_s}.rrd", {:step => 60, 
  							:heartbeat => 120, 
  							:ds => [{:name => "upload", 
  									     :type => "GAUGE"},
  						          {:name => "download", 
  						   	       :type => "GAUGE"},
                        {:name => "rx", 
                         :type => "GAUGE"},
                        {:name => "tx", 
                         :type => "GAUGE"}],
  						  :xff => ".5",
  						  :rra => [{:type => "average", 
  						   	        :steps => 1, 
  						   	        :rows => 20160}]})
  end

  def self.files_array
  	array = []
  	Dir.foreach("/var/www/graphs/") { |f| array << f }
  	return array
  end
  
end