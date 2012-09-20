# coding: utf-8
class Mtreenode < ActiveRecord::Base
  self.table_name = "mtree_node"
  self.primary_key = "id"
  belongs_to :moduletarifftree, :class_name => 'Moduletarifftree'
end
