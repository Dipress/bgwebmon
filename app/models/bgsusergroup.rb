class Bgsusergroup < ActiveRecord::Base
	self.table_name =  "bgs_user_group"

	belongs_to :user, class_name: "User", foreign_key: "id"
	belongs_to :bgsgroup, class_name: "Bgsgroup", foreign_key: "id"
  
  attr_accessible :uid, :gid
end
