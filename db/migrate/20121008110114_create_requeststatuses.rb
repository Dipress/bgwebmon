class CreateRequeststatuses < ActiveRecord::Migration
  def change
    create_table :requeststatuses do |t|
      t.column :id, :int, :primary => true, :null => false
      t.column :title, :string, :limit => 30, :null => false
      t.timestamps
    end
  end
end
