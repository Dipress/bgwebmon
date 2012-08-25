# coding: utf-8
class Contract < ActiveRecord::Base
  self.table_name =  "contract"
  self.primary_key = "id"
  
  has_one :dialupip, :through => :dialuplogin
  has_one :dialupalias, :through => :dialuplogin
  has_one :dialuplogin, :class_name => 'Dialuplogin', :foreign_key =>'cid'
  has_one :contract_module, :class_name => 'ContractModule', :foreign_key => 'cid'
  
  has_many :bgmodules, :through => :contract_module

  attr_accessible :rx, :tx, :online

  validates :rx, :presence => true, :numericality => { :only_integer => true }
  validates :tx, :presence => true, :numericality => { :only_integer => true }
  validates :online, :inclusion => {:in => [true, false]}
end