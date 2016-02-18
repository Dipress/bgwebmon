class ChangeLimitForTextField < ActiveRecord::Migration
  def self.up
  	change_column(:tcomments, :text, :text)
  end
end
