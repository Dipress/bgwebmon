# coding: utf-8
class Moduletarifftree < ActiveRecord::Base
  self.table_name = "module_tariff_tree"
  self.primary_key = "id"
  belongs_to :tarifftreelink, :class_name => 'Tarifftreelink', :foreign_key => 'tree_id'
  belongs_to :contracttreelink, :class_name => 'Contracttreelink', :foreign_key => 'tree_id'
  has_many :mtreenodes, :class_name => 'Mtreenode', :foreign_key =>'mtree_id'
end
