# coding: utf-8
class ContractParameterType7 < ActiveRecord::Base

  self.table_name = "contract_parameter_type_7"
  self.primary_key = "pid"

  belongs_to :contract, :class_name => 'Contract', :foreign_key => 'cid'
  belongs_to :contract_parameter_type7_value, :class_name => 'ContractParameterType7Value', :foreign_key => 'val'

end
