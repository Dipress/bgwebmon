class CreateTstatuses < ActiveRecord::Migration
  def change
    create_table :tstatuses do |t|
      t.string :title, :limit => 120, :null => false
    end
  end
end
