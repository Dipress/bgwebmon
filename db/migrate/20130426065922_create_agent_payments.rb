class CreateAgentPayments < ActiveRecord::Migration
  def change
    create_table :agent_payments do |t|
      t.references :contract
      t.references :user
      t.references :manager
      t.decimal :value
      t.string :text
      t.datetime :managed_at

      t.timestamps
    end
    add_index :agent_payments, :contract_id
    add_index :agent_payments, :user_id
    add_index :agent_payments, :manager_id
  end
end
