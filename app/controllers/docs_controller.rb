# coding: utf-8
class DocsController < ApplicationController
  before_filter :checklogedin
  before_filter :ip_check
  before_filter :sadmin
  def index
  	page = params[:page]
    params[:page].nil? ? page = 1 : page = params[:page] 
    @contracts = Contract.paginate(:page => page, 
                             	   :per_page => 20,
                             	   :order => "title ASC").where(["pgid=? or pgid=? and status=?",1,2,0])
    @title= "Данные по договорам"
  	@user = current_user()
  end
end
