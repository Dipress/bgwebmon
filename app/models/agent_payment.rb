class AgentPayment < ActiveRecord::Base
  include Textable
  include Userable

  belongs_to :contract
  belongs_to :manager, class_name: "User", foreign_key: "manager_id"
  belongs_to :confirmation, class_name: "User", foreign_key: "confirmation_id"
  belongs_to :agent_payment_currency
  attr_accessible :managed_at, :value, :contract_id, :manager_id, :confirmation_id, :confirmation_at, :agent_payment_currency_id

  validates :contract_id, :value, presence: true
  validates :agent_payment_currency_id, presence: true
end
