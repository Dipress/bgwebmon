# coding: utf-8
class Contract < ActiveRecord::Base
  include ActiveModel::SerializerSupport
  include Tire::Model::Search
  include Tire::Model::Callbacks
  self.table_name =  "contract"
  self.primary_key = "id"

  attr_accessible :status, :status_date, :date1, :date2

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
  has_many :contract_statuses, :class_name => 'ContractStatus', :foreign_key => 'cid'
  has_many :contract_status_logs, :class_name => 'ContractStatusLog', :foreign_key => 'cid'
  has_many :inet_services, class_name: 'InetService', foreign_key: 'contractId'


  ### Tire
  mapping do
    indexes :title, type: 'string', analyzer: 'snowball'
    indexes :contract, type: 'string', analyzer: 'snowball'
    indexes :contract_parameter_type7, type: 'object' do
      indexes :val, type: 'integer'
      indexes :pid, type: 'integer'
    end
    #indexes :dialuplogins, type: 'object' do
      #indexes :dialupalias, type: 'object' do
        #indexes :login_alias, type: 'string', analyzer: 'snowball'
      #end
      #indexes :dialupip, type: 'object' do
        #indexes :human_ip, type: 'string', analyzer: 'snowball'
      #end
    #end
    indexes :inet_services, type: 'object' do
      indexes :login, type: 'string', analyzer: 'snowball'
      indexes :inet_resource_subscriptions, type: 'object' do
        indexes :human_ip, type: 'string', analyzer: 'snowball'
      end
    end
    indexes :contract_parameter_type8, type: 'object' do
      indexes :cid, type: 'integer'
      indexes :val, type: 'integer'
    end
  end

  def self.filter params
    tire.search(load: false, page: (params[:page] || 1).to_i, per_page: (params[:per_page] || 12).to_i) do
      query { string "*#{params[:term]}*" }                                     unless params[:term].blank?
      filter :term, 'contract_parameter_type8.val' => params[:cid]              unless params[:cid].blank?
      filter :term, 'contract_parameter_type7.val' => params[:bs_id]            unless params[:bs_id].blank?
      filter :term, 'contract_parameter_type7.pid' => 54                        unless params[:bs_id].blank?
    end
  end

  def to_indexed_json
    to_json(include: { inet_services: {include: { inet_resource_subscriptions: { :methods => ['human_ip'] } }}, contract_parameter_type8: {}, contract_parameter_type7: {}})
  end
  ### Methods


  def self.tariffs_array(id)
    array = []
    tarray = []
    allsums = 0
    fincost = 0
    id = Contract.find(id)
    id.ctariffs.where("date2 is NULL").each do |tp|
      title = tp.tariffplan.title
      tp.tariffplan.moduletarifftrees.each do |md|
        mtreen = md.mtreenodes.where("type LIKE '%_cost'").find(:all, :select => "type as etype, data").last
        if mtreen != nil
          fincost = mtreen.data.gsub("cost&", "").gsub("%type&1", "").gsub("type&1%", "").gsub("%type&0", "")
          allsums += fincost.to_i
        end
      end
      tarray << {:title => title , :cost => fincost }
    end
    pfincost = 0
    id.contracttreelinks.where("date2 is NULL").each do |ptp|
      title = ptp.title
      ptp.moduletarifftrees.each do |pmd|
        pmtreen = pmd.mtreenodes.where("type LIKE '%_cost'").find(:all, :select => "type as etype, data").last
        if pmtreen != nil
          pfincost = pmtreen.data.gsub("cost&", "").gsub("%type&1", "").gsub("type&1%", "").gsub("%type&0", "").gsub("type&0%", "")
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

  def mobile_phone
    allowed = %w[+38050 +38066 +38095 +38099 +38067 +38096 +38097 +38098 +38063 +38093 +38068 +38091 +38092]
    phone = self.phones.where(pid: 14).first
    if phone.nil?
      nil
    else
      phone = "+380" + phone.value.gsub(/\W/,"").match(/[0-9]{9}$/).to_s
      p phone
      if allowed.include? phone[0..5]
        phone
      else
        nil
      end
    end
  end

  def russian_mobile
    phone = phones.where(pid: 14).first
    phone = phone.value if phone.present?
    (phone =~ /^79\d{9}$/)? "+" + phone : nil
  end

  def current_balance
    Balance.by_cmy self.id, Time.now.month, Time.now.year
  end

  def self.cached_users id=0
    Rails.cache.fetch("cached_users_for#{id}", expires_in: 30.minutes) do
      contracts = Contract.joins(:contract_parameter_type7).where('contract_parameter_type_7.pid=54')
      if id.eql?(0)
        contracts.map do |c|
          ContractSerializer.new(c, root: false).serializable_hash
        end
      else
        contracts.joins(:contract_parameter_type8).where("contract_parameter_type_8.val=#{id}").map do |c|
          ContractSerializer.new(c, root: false).serializable_hash
        end
      end
    end
  end

  def last_balance
    @last_balance ||= get_last_balance
  end

  def get_last_balance
    summa = balances.order("yy DESC, mm DESC").first
    if summa.nil?
      summa = Balance.create! summa1: 0, summa2: 0, summa3: 0, summa4: 0, yy: Time.now.year, mm: Time.now.month, cid: self.id
    elsif summa.mm < Time.now.month || summa.yy < Time.now.year
      summa = Balance.create! summa1: (summa.summa1 + summa.summa2 - summa.summa3 - summa.summa4), summa2: 0, summa3: 0, summa4: 0, yy: Time.now.year, mm: Time.now.month, cid: self.id
    end
    summa
  end

  def balance_summa
    summa = last_balance
    summa.summa1 + summa.summa2 - summa.summa3 - summa.summa4
  end

end
