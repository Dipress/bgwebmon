# coding: utf-8
class Dialupalias < ActiveRecord::Base
  self.table_name = "user_alias_6"
  self.primary_key = "login_id"

  belongs_to :dialuplogin, :class_name => 'Dialuplogin', :foreign_key => 'login_id'
  has_one :contract, :through => :dialuplogin

  has_many :dialuperrors, :class_name => 'Dialuperror', :foreign_key => 'lid'

  def self.change_ip
  	dontfind = []
  	File.open(Rails.root.join("ips.txt"), 'r+') do |file|
      file.each_line { |line|
  	    array  = line.gsub(/\n$/, "").split("\ ")
  	    login = array[0].gsub(/login\=/, "")
  	    ip = array[1].gsub(/ip\=/, "")
  	    billing_ip = array[2].gsub(/vip\=/, "") 
  	    login_alias = Dialupalias.find_by_login_alias login
  	    if !login_alias.nil?
  	      login = login_alias.dialuplogin
  	      login.dialupip.aton billing_ip
  	      contract = login.contract
  	      shluz = contract.contract_parameter_type1.where(pid: 35).first
  	      shluz.update_attribute(:val, "#{ip.gsub(/\.[0-9]+$/, ".1")}")
  	      #dogovor_ip = contract.contract_parameter_type1.where(pid: 34).first
  	      #dogovor_ip.update_attribute(:val, "#{ip} / 255.255.255.0")
          ActiveRecord::Base.connection.execute("UPDATE `contract_parameter_type_1` SET `val` = '#{"#{ip} / 255.255.255.0"}' WHERE `contract_parameter_type_1`.`pid` = 34 AND `contract_parameter_type_1`.`cid` = #{contract.id}")
          #p login
          #p ip
          #p billing_ip
        else
        	dontfind.push login
  	    end
  	  }
  	  file.close
  	end
  	p dontfind
  end

end