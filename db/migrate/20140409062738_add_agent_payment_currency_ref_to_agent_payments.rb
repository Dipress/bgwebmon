class AddAgentPaymentCurrencyRefToAgentPayments < ActiveRecord::Migration
  def self.up
    add_column :agent_payments, :agent_payment_currency_id, :integer
    add_index  :agent_payments, :agent_payment_currency_id
  end
end