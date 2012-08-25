# coding: utf-8
class ContractModule < ActiveRecord::Base

  self.table_name =  "contract_module"
  self.primary_key = "cid"
  
  belongs_to :contract, :class_name => 'Contract', :foreign_key =>'cid'
  belongs_to :bgmodule, :class_name => 'Bgmodule', :foreign_key => 'mid'
end