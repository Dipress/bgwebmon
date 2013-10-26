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
      #system('chmod -R 777 #{Rrdcron.dir_name}graphs/*.rrd')
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