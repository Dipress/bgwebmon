class CreateInetResourceSubscriptions < ActiveRecord::Migration
  def change
    create_table :inet_resource_subscriptions do |t|

      t.timestamps
    end
  end
end
