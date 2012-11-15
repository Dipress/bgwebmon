class CreateTfiles < ActiveRecord::Migration
  def change
    create_table :tfiles do |t|
      t.string :title, :limit => 120, :null => false
      t.string :file_file_name, :null => false
      t.string :file_content_type, :null => false
      t.string :file_file_size, :null => false
      t.integer :task_id, :null => false
      t.timestamps
    end
  end
end
