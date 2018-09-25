# coding: utf-8
class ContractParameterType2 < ActiveRecord::Base

  self.table_name = "contract_parameter_type_2"
  self.primary_key = "pid"

  belongs_to :contract, :class_name => 'Contract', :foreign_key => 'cid'
  belongs_to :address_house, :class_name => 'AddressHouse', :foreign_key => 'hid'

  attr_accessible :hid
end
