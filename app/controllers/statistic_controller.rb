class StatisticController < ApplicationController
before_filter :checklogedin, :only => [:index, :show]
  def index
    @nodes = ContractParameterType7Value.where(:pid => 54).order('title ASC')
  end

  def show
  	nodeid = params[:id]
  	cpt7v = ContractParameterType7Value.find(nodeid)
  	@nodename = cpt7v.title
  	@contracts = []
  	@allcost = 0
  	cpt7v.contracts.each{|c|
  		if c.status.eql?(0)
  			tfc = tarrifs_from_cid(c.id)
  			@contracts << tfc
  			@allcost += tfc[:tariffs][0]["allcost"]
  		end
  	}
  end

private
	def tarrifs_from_cid(cid)
		contract = Contract.find(cid)
		return array = {:title => contract.title, :comment => contract.comment, :tariffs => Contract.tariffs_array(cid)}
	end
end
