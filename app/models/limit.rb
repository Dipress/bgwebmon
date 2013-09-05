class Limit < ActiveRecord::Base
  self.table_name = "log_contract_limit"
  self.primary_key = "id"
  belongs_to :contract, :class_name => 'Contract', :foreign_key => 'cid'
  belongs_to :user, :class_name => 'User', :foreign_key => 'uid'
end