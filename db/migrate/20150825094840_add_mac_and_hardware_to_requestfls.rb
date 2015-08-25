class AddMacAndHardwareToRequestfls < ActiveRecord::Migration
  def up
    change_table :requestfls do |t|
      t.string :mac
      t.string :hardware
    end
  end
end
