# coding: utf-8
require 'bigdecimal'

class ScrapNodesTask
  def self.putdata
    mm = Time.now.month
    year = Time.now.year

    reports = Report.all.to_a
    reports.each do |r|
	    contracts_all = []
	    contracts_active = 0
      balance = 0.00
      outcome = 0.00
	    
	    node = ContractParameterType7Value.where(pid: 54, id: r.billing_node_id).first
	    contracts_active = node.contracts.where(status: 0).count
      contracts_all = node.contracts.map { |c| c.id }

	    contracts_all.map do |c|
		    b = Balance.operating(c, mm, year).to_d
		    balance += b
      end
      outcome = r.rent.to_d + r.channel.to_d + r.electro.to_d + r.other.to_d

	r.update_attributes(
		    contracts_all: contracts_all.count,
		    contracts_active: contracts_active,
		    income: format("%.2f", balance),
		    outcome: format("%.2f", outcome),
	)
    end
  end
end
