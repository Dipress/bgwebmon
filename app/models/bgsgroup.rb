class Bgsgroup < ActiveRecord::Base
	self.table_name =  "bgs_group"
	self.primary_key = "id"

	has_many :bgsusergroups, class_name: "Bgsusergroup", foreign_key: "gid"
  has_many :users, through: :bgsusergroups

  attr_accessible :title, :comment, :cgr, :pids, :cgr_mode


end
