class ChangeValueToAgentPayments < ActiveRecord::Migration
  def self.up
  	change_table :agent_payments do |t|
  		t.change :value, :decimal, precision: 10, scale: 2
  	end
  end
end