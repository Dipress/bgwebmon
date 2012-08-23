class Dialupip < ActiveRecord::Base
  self.table_name = "radius_pair_ip_#{Bgmodule.find_by_name("dialup").id}"
  self.primary_key = "id"
  belongs_to :dialupip, :class_name => 'Dialupip', :foreign_key => 'id'
end
