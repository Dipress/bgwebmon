class AgentPayment < ActiveRecord::Base
  include Textable
  include Userable

  belongs_to :contract
  belongs_to :manager, class_name: "User", foreign_key: "manager_id"
  attr_accessible :managed_at, :value, :contract_id, :manager_id

  validates :contract_id, :value, presence: true
end
