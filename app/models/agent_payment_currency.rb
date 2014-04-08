class AgentPaymentCurrency < ActiveRecord::Base

  attr_accessible :name, :scode, :nominal, :curs

  has_many :agent_payments

  validates :name, presence: true, length: { maximum: 256 }
  validates :scode, presence: true, length: { maximum: 60 }
  validates :nominal, presence: true
  validates :curs, presence: true
end
