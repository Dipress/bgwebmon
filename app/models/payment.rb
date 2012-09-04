# coding: utf-8
class Payment < ActiveRecord::Base
  self.table_name =  "contract_payment"
  self.primary_key = "id"

  belongs_to :contract, :class_name => 'Contract', :foreign_key => 'cid'
  belongs_to :payment_type, :class_name => 'PaymentType', :foreign_key =>'pt'
end