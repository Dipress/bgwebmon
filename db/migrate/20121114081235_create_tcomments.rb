class CreateTcomments < ActiveRecord::Migration
  def change
    create_table :tcomments do |t|
      t.string :text, :limit => 360, :null => false
      t.integer :user_id, :null => false
      t.integer :task_id, :null => false
      t.timestamps
    end
  end
end
