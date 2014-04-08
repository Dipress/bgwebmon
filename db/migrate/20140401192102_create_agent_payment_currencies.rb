class CreateAgentPaymentCurrencies < ActiveRecord::Migration
  def self.up
    create_table :agent_payment_currencies, options: 'default charset=utf8' do |t|
    	t.string :name, limit: 256, null: false
    	t.string :scode, limit: 60, null: false
    	t.integer :nominal
    	t.decimal :curs, precision: 8, scale: 2
      t.timestamps
    end
  end

  def self.down
  	drop_table :agent_payment_currencies
  end
end
