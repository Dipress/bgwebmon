class AgentPayment < ActiveRecord::Base
  include Textable
  include Userable

  belongs_to :contract
  belongs_to :manager, class_name: "User", foreign_key: "manager_id"
  belongs_to :confirmation, class_name: "User", foreign_key: "confirmation_id"
  attr_accessible :managed_at, :value, :contract_id, :manager_id, :confirmation_id, :confirmation_at

  validates :contract_id, :value, presence: true
end
