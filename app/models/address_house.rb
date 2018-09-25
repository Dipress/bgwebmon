# coding: utf-8
class AddressHouse < ActiveRecord::Base

  self.table_name = "address_house"
  self.primary_key = "id"

  has_many :contract_parameter_type2, class_name: 'ContractParameterType2', :foreign_key => 'hid'

  attr_accessible :id, :house
end
