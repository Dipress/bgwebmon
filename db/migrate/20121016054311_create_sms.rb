class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.integer :id, :primary => true, :null => false
      t.date :date, :null => false
      t.integer :cid, :null => false
      t.integer :smstype_id, :null => false
    end
  end
end
