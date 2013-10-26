# coding: utf-8
require "rrd"
class RrdcronTasks
  
  def self.datacreator
  		files_array = files_array()
  		Dialupalias.all.each { |a| 
  			#if  files_array.find{ |f| f.eql?("#{a.login_alias.downcase}.rrd") } == nil
        dl = a.dialuplogin.dialupip
        if !dl.nil?
          dlip = Dialupip.ntoa(dl.ip)
          if  files_array.find{ |f| f.eql?("#{dlip.gsub(/\./,"")}.rrd") } == nil
  				#Rrdcron.add_graph(a.login.downcase)
            Rrdcron.add_graph(dlip.gsub(/\./,""))
  			  end
        end
  		}
      #system('chmod -R 777 #{Rrdcron.dir_name}graphs/*.rrd')
  end

  def self.test
    x = self.dir_name
    puts "#{x}"
  end

private

  def self.dir_name
    File.dirname(__FILE__).gsub(/webmon\/current\/cronscripts/,"")
  end

  def self.add_graph(login)
  	RRD.create("#{Rrdcron.dir_name}graphs/#{login.to_s}.rrd", {:step => 60, 
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
  	Dir.foreach("#{Rrdcron.dir_name}graphs/") { |f| array << f }
  	return array
  end
  
end