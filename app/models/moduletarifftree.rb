# coding: utf-8
class Moduletarifftree < ActiveRecord::Base
  setlf.table_name = "module_tariff_tree"
  self.primary_key = "id"
  belongs_to :tarifftreelink, :class_name => 'Tarifftreelink'
  has_many :mtreenodes, :class_name => 'Mtreenode', :foreign_key =>'mtree_id'
end
