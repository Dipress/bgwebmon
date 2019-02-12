class Node
	include Mongoid::Document
	include Mongoid::Timestamps::Created
	include Mongoid::Timestamps::Updated

	before_save :put_the_data

	belongs_to :report, class_name: 'Report'
	belongs_to :contract_parameter_type7_value

	attr_accessible :name, :billing_node_id, :contracts_all, :contracts_active, :income, :frequency, :rich

	validates :billing_node_id, presence: true
	validates :contracts_all, presence: true

	field :name, type: String
	field :billing_node_id, type: Integer
	field :contracts_all, type: Integer, default: 0
	field :contracts_active, type: Integer, default: 0
	field :income, type: String, default: "0.00"
	field :frequency, type: String, default: "0.00"
	field :rich, type: String

	private

	  def put_the_data
		  mm = Time.now.month
		  year = Time.now.year
		  all = []
		  active = 0
		  balance = 0.00
		  node = ContractParameterType7Value.where(pid: 54, id: self.billing_node_id).first
		  active = node.contracts.where(status: 0).count
		  all = node.contracts.map { |c| c.id }
		  all.map do |c|
			  b = Balance.operating(c, mm, year).to_d
			  balance += b
		  end

		  self.contracts_active = active
		  self.contracts_all = all.count
			self.income = balance
	end
end
