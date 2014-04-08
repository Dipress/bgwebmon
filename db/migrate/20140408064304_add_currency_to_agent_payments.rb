class AddCurrencyToAgentPayments < ActiveRecord::Migration
  def self.up
  	change_table :agent_payments do |t|
      t.references :agent_payment_currency, null: false
    end
  end
end
