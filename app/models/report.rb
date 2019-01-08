class Report
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  belongs_to :contract_parameter_type7_value

  field :title, type: String
  field :billing_node_id, type: Integer
  field :contracts_all, type: Integer
  field :contracts_active, type: Integer
  field :income, type: String, default: "0.00"
  field :rent, type: String, default: "0.00"
  field :channel, type: String, default: "0.00"
  field :electro, type: String, default: "0.00"
  field :frequency, type: String, default: "0.00"
  field :other, type: String, default: "0.00"
  field :outcome, type: String, default: "0.00"
end
