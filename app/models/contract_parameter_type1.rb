# coding: utf-8
class ContractParameterType1 < ActiveRecord::Base

  self.table_name = "contract_parameter_type_1"
  self.primary_key = "pid"

  attr_accessible :cid, :pid, :val

  belongs_to :contract, :class_name => 'Contract', :foreign_key => 'cid'
end
