# coding: utf-8
class Contracttreelink < ActiveRecord::Base
establish_connection :production
  self.table_name = "contract_tree_link"
  self.primary_key = "tree_id"
  belongs_to :contract, :class_name => 'Contract'
  has_many :moduletarifftrees, :class_name => 'Moduletarifftree', :foreign_key =>'tree_id'
end
