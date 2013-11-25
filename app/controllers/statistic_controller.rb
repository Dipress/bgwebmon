# coding: utf-8
class StatisticController < ApplicationController
before_filter :checklogedin
before_filter :ip_check

  def index
    @title = "Список точек подключения"
    @nodes = ContractParameterType7Value.where( :pid => 54 ).order( 'title ASC' )
    #@regions = regions_array @nodes
    #@nodes = []
    #@regions.each{|r| @nodes << nodes_from_region( r )}
    @user = current_user
    #@nodes_contracts = ContractParameterType7Value.where( :pid => 54 ).order( 'title ASC' )

    respond_to do |format|
      format.html #index.html.haml
      format.json { render json: @nodes, root: false }
    end
  end

  def show
    @title = "Доходы базовой станции"
  	nodeid = params[:id]
   	cpt7v = ContractParameterType7Value.find nodeid
  	@nodename = cpt7v.title
  	like = search_title
  	@contracts = []
  	@allcost = 0
  	cpt7v.contracts.each{|c|
  		if c.status.eql?(0)
  			if member(c.id)
  				tfc = tarrifs_from_cid(c.id)
  				@contracts << tfc
  				@allcost += (tfc[:tariffs][0]["allcost"])
  			end
  		end
  	}
    @count = @contracts.count
    @user = current_user()
  end

private
	def tarrifs_from_cid(cid)
		contract = Contract.find(cid)
		return array = {:title => contract.title, 
                    :comment => contract.comment, 
                    :tariffs => Contract.tariffs_array(cid)}
	end

  def regions_array(nodes)
    scan = /^([А-Я]|[а-я])+\ \-\ /
    array = []
    nodes.each{|z| array << z.title.match(scan).to_s.gsub(/\ \-\ /,"")}
    return array.uniq
  end

  def nodes_from_region(region)
    array = []
    ContractParameterType7Value.where("pid='54' and title like '#{region}%'").order('title ASC').each{|n|
      array << {:id => n.id, :title => n.title}}
    return array = {:region => region, :nodes => array}
  end

end
