class CreateSmstypes < ActiveRecord::Migration
  def change
    create_table :smstypes do |t|
      t.integer :id, :primary => true, :null => false
      t.string :title, :limit => 64, :null => false
    end
  end
end
