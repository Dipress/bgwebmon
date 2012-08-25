# coding: utf-8
class Contract < ActiveRecord::Base
  self.table_name =  "contract"
  self.primary_key = "id"
  
  has_one :dialupip, :through => :dialuplogin
  has_one :dialupalias, :through => :dialuplogin
  has_one :dialuplogin, :class_name => 'Dialuplogin', :foreign_key =>'cid'
end