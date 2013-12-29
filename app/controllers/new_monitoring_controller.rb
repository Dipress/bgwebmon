# coding: utf-8
class NewMonitoringController < ApplicationController
  respond_to :html, :json
  before_filter :checklogedin
  before_filter :find_contract, only: [:show]
  
  def index
    respond_to do |format|
      @user = current_user
      params[:cid] = (@user.contract_cid == 0) ? nil : @user.contract_cid
      contracts = Contract.filter(params)
      format.json { render json: contracts.results,
                           meta: { page:          contracts.current_page, 
                                   per_page:      12, 
                                   total_pages:   contracts.total_pages }
                  }
      format.html
    end
  end

  def show
  	@graph = graph
    respond_to do |format|
  	  format.json { render json: @graph }
  	  format.html
    end
  end

private
  
  def graph
    time = Time.now.to_i - (60*60*params[:hour].to_i)
    ago = Time.now - params[:hour].to_i.hours
    name = "График абонента #{@contract.title} - #{@contract.comment}, c #{ago.strftime('%d.%m.%Y %H:%M:%S')} по #{Time.now.strftime('%d.%m.%Y %H:%M:%S')}"
    image_name = "#{params[:ip].gsub(/\./, '')}_#{Time.now.strftime("%Y%m%d%H%M%S%12N")}"
    cmd = "rrdtool graph /var/www/webmon/current/public/graphs/#{image_name}.png -b 1024 -s #{time} -w 860 -h 200 -a PNG -t '#{name}' -v='скорость бит в секунду' --slope-mode  --lower-limit=0 DEF:a='/var/www/graphs/#{params[:ip].gsub(/\./, '')}.rrd':download:AVERAGE AREA:a#00CC00:'Входящий трафик' DEF:b='/var/www/graphs/#{params[:ip].gsub(/\./, '')}.rrd':upload:AVERAGE LINE1:b#0000FF:'Исходящий трафик'"
    system(cmd)
    "/graphs/#{image_name}.png"
  end

  def find_contract
    @contract = Contract.find(params[:id])
  end
end