# coding: utf-8
class Bgmodule < ActiveRecord::Base
  self.table_name = "module"
  self.primary_key = "id"

  has_many :contract_modules, :class_name => 'ContractModule', :foreign_key =>'mid'
  has_many :contracts, :through => :contract_modules
end
