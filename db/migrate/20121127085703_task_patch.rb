class TaskPatch < ActiveRecord::Migration
  def up
  	add_column :tasks, :observers, :string, :null => false
  	add_column :tasks, :contract_cid, :integer
  end

  def down
  	remove_column :tasks, :observers
  	remove_column :tasks, :contract_cid
  end
end
