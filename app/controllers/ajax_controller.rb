class AjaxController < ApplicationController
before_filter :checklogedin
before_filter :ip_check 
  # GET /api/get_contracts.json
  def get_contracts
    @contracts = Contract.where ["title LIKE '%#{params[:search]}%' OR comment LIKE '%#{params[:search]}%'"]

    respond_to do |format|
      #format.html # index.html.erb
      format.json { render json: @contracts.map{|c| { id: c.id, name: "#{c.title} - #{c.comment}" }}, root: false }
    end
  end
end