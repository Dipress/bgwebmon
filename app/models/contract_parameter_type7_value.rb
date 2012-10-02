# coding: utf-8
class ContractParameterType7Value < ActiveRecord::Base

  self.table_name = "contract_parameter_type_7_values"
  self.primary_key = "id"

  has_many :contract_parameter_type7, :class_name => 'ContractParameterType7', :foreign_key => 'val'
  has_many :contracts, :through => :contract_parameter_type7
end
