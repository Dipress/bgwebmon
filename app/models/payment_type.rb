# coding: utf-8
class PaymentType < ActiveRecord::Base
  self.table_name =  "contract_payment_types"
  self.primary_key = "id"

  has_many :payments, :class_name => 'Payment', :foreign_key => 'pt'
end