class ChangeDataTypeForRequestfls < ActiveRecord::Migration
  def self.up
    change_column :requestfls, :adress_post, :string, limit: 200, null: false
    change_column :requestfls, :adress_connection, :string, limit: 200, null: false
    change_column :requestfls, :pasport_authority, :string, limit: 90, null: false
  end

  def self.down
    change_column :requestfls, :adress_post, :string, limit: 200, null: false
    change_column :requestfls, :adress_connection, :string, limit: 200, null: false
    change_column :requestfls, :pasport_authority, :string, limit: 90, null: false
  end
end
