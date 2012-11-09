class Discardrfls < ActiveRecord::Migration
  def up
  	add_column :requestfls, :discard, :string, :limit => 400
  end

  def down
  	remove_column :requestfls, :discard
  end
end
