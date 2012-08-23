# coding: utf-8
class Rxtxonline < ActiveRecord::Migration
  def self.up
    add_column :contract, :online, :boolean, :default => 0
    add_column :contract, :rx, :bigint, :default => 0
    add_column :contract, :tx, :bigint, :default => 0
  end

  def self.down
    remove_column :contract, :online
    remove_column :contract, :rx
    remove_column :contract, :tx
  end
end
