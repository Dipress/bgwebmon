# coding: utf-8
class Dialuplogin < ActiveRecord::Base
  self.table_name = "user_login_#{Bgmodule.find_by_name("dialup").id}"
  self.primary_key  = "id"
  belongs_to :contract, :class_name => 'Contract', :foreign_key => 'cid'
  has_one :dialupip, :class_name => 'Dialupip', :foreign_key =>'id'
  has_one :dialupalias, :class_name => 'Dialupalias', :foreign_key =>'login_id'
end
