# coding: utf-8
class Contract < ActiveRecord::Base
  self.table_name =  "contract"
  self.primary_key = "id"

  has_many :phones, :class_name => "Phone", :foreign_key => "cid"

  has_many :agent_payments

  has_many :smses, :class_name => "Sms", :foreign_key => "cid"

  has_many :flags, :class_name => "Flag", :foreign_key => "cid"

  has_many :dialuperrors, :class_name => 'Dialuperror', :foreign_key => 'cid'

  has_many :payments, :class_name => 'Payment', :foreign_key => 'cid'

  has_many :balances, :class_name => 'Balance', :foreign_key => 'cid'

  has_many :dialuplogins, :class_name => 'Dialuplogin', :foreign_key =>'cid'
  has_many :dialupips, :through => :dialuplogins
  has_many :dialupaliases, :through => :dialuplogins
  
  has_many :contract_modules, :class_name => 'ContractModule', :foreign_key => 'cid'
  has_many :bgmodules, :through => :contract_modules

  has_many :ctariffs, :class_name => 'Ctariff', :foreign_key =>'cid'
  has_many :tariffplans, :through => :ctariffs
  has_many :contracttreelinks, :class_name => 'Contracttreelink', :foreign_key =>'cid'

  has_many :contract_parameter_type1, :class_name => 'ContractParameterType1', :foreign_key => 'cid'

  has_many :contract_parameter_type2, :class_name => 'ContractParameterType2', :foreign_key => 'cid'

  has_many :contract_parameter_type6, :class_name => 'ContractParameterType6', :foreign_key => 'cid'

  has_many :contract_parameter_type7, :class_name => 'ContractParameterType7', :foreign_key => 'cid'
  has_many :contract_parameter_type7_values, :through => :contract_parameter_type7

  has_many :contract_parameter_type8, :class_name => 'ContractParameterType8', :foreign_key => 'cid'

  def self.tariffs_array(id)
    array = []
    tarray = []
    allsums = 0
    fincost = 0
    id = Contract.find(id)
    id.ctariffs.where("date2 is NULL").each do |tp|
      title = tp.tariffplan.title
      tp.tariffplan.moduletarifftrees.each do |md|
        mtreen = md.mtreenodes.where("type LIKE '%_cost'").find(:all, :select => "type as etype, data")[0]
        if mtreen != nil
          fincost = mtreen.data.gsub(/(.+)&/,"")
          allsums += fincost.to_i
        end
      end
      tarray << {:title => title , :cost => fincost }
    end
    pfincost = 0
    id.contracttreelinks.where("date2 is NULL").each do |ptp|
      title = ptp.title
      ptp.moduletarifftrees.each do |pmd|
        pmtreen = pmd.mtreenodes.where("type LIKE '%_cost'").find(:all, :select => "type as etype, data")[0]
        if pmtreen != nil
          pfincost = pmtreen.data.gsub(/(.+)&/,"")
          allsums += pfincost.to_i
        end
      end
      tarray << {:title => title , :cost => pfincost }
    end
    return array << {"tplans" => tarray, "allcost" => allsums}
  end

  def self.tariffs_all
    File.open(Rails.root.join('public/kirill.txt'), 'a') do |file|
      ContractParameterType7Value.where(id:[100,109,110,73,74,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92]).order("title ASC").each do |r|
        file.puts "       #{r.title}"
        r.contracts.each do |c|
          file.puts "#{c.comment} - #{Contract.tariffs_array(c.id)[0]["allcost"]}"
        end
      end
    end
  end

end