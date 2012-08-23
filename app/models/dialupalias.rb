# coding: utf-8
class Dialupalias < ActiveRecord::Base
  self.table_name = "user_alias_#{Bgmodule.find_by_name("dialup").id}"
  self.primary_key = "login_id"
  belongs_to :dialuplogin, :class_name => 'Dialuplogin', :foreign_key => 'login_id'
  has_one :contract, :through => :dialuplogin
end
