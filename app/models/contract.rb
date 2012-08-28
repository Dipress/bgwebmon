# coding: utf-8
class Contract < ActiveRecord::Base
  self.table_name =  "contract"
  self.primary_key = "id"

  has_many :dialuplogins, :class_name => 'Dialuplogin', :foreign_key =>'cid'
  has_many :dialupips, :through => :dialuplogins
  has_many :dialupaliases, :through => :dialuplogins
  
  has_many :contract_modules, :class_name => 'ContractModule', :foreign_key => 'cid'
  has_many :bgmodules, :through => :contract_modules

  attr_accessible :rx, :tx, :online

  validates :rx, :presence => true, :numericality => { :only_integer => true }
  validates :tx, :presence => true, :numericality => { :only_integer => true }
  validates :online, :inclusion => {:in => [true, false]}
end