class AddBirthplaceToRequestfls < ActiveRecord::Migration
  def up
    change_table :requestfls do |t|
      t.string :birthplace
    end
  end
end
