# coding: utf-8
class ContractParameterType7Value < ActiveRecord::Base

  self.table_name = "contract_parameter_type_7_values"
  self.primary_key = "id"

  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many :contract_parameter_type7, class_name: 'ContractParameterType7', foreign_key: 'val'
  has_many :contracts, through: :contract_parameter_type7


  mapping do
    indexes :id, type: :integer
    indexes :pid, type: :integer
    indexes :title, analyzer: 'snowball', boost: 100
  end

  def self.search(params)
    tire.search(load: true) do
      query { string params[:query], default_operator: "AND"} if params[:query].present?
      filter :range, pid: { gte: 54, lte: 54}
      sort { by :title, 'asc' } if params[:query].blank?
    end 
  end

end
