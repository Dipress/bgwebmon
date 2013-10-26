class AddConfirmationToAgentPayments < ActiveRecord::Migration
  def change
  	change_table :agent_payments do |t|
      t.references :confirmation, index: true
      t.datetime :confirmation_at
    end
  end
end
