# coding: utf-8
class Contract < ActiveRecord::Base
  self.table_name =  "contract"
  self.primary_key = "id"
#  has_many :cbalances, :class_name => 'Cbalance', :foreign_key =>'cid'
#  has_many :addresses, :class_name => 'Addresses', :foreign_key =>'cid'
#  has_many :ctariffs, :class_name => 'Ctariff', :foreign_key =>'cid'
  has_one :dialupip, :through => :dialuplogin
  has_one :dialupalias, :through => :dialuplogin
  has_one :dialuplogin, :class_name => 'Dialupuserlogin', :foreign_key =>'cid'
#  has_many :contracttreelink, :class_name => 'Contracttreelink', :foreign_key =>'cid'
#  belongs_to :region, :class_name => 'Region'
#  belongs_to :connectionpoint, :class_name => 'Сonnectionpoint'
end