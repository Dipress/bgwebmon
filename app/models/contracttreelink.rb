# coding: utf-8
class Contracttreelink < ActiveRecord::Base
  self.table_name = "contract_tree_link"
  self.primary_key = "tree_id"
  belongs_to :contract, :class_name => 'Contract', :foreign_key => "cid"
  has_many :moduletarifftrees, :class_name => 'Moduletarifftree', :foreign_key =>'tree_id'
end
