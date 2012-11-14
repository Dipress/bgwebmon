class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, :limit => 120, :null => false
      t.string :text, :limit => 1000, :null => false
      t.integer :user_id, :null => false
      t.integer :tstatus_id, :null => false
      t.integer :take_id
      t.time :end_at
      t.timestamps
    end
  end
end
