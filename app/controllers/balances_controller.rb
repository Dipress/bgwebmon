# coding: utf-8
class BalancesController < ApplicationController
  layout false, :except => [:index]
  before_filter :checklogedin
  before_filter :ip_check
  before_filter :sadmin
  def index
  	@user = current_user()
  	@index = 1
  	@Title = "Балансы абонентов"
	if DateTime.now.month.to_s.size == 1
		@month = "0"+DateTime.now.month.to_s
	else
		@month = DateTime.now.month.to_s
	end
	@year =  DateTime.now.year.to_s
	@ids = Contract.where("pgid='1' AND title LIKE '04-%'").order('title ASC')
	@wherestring = "yy=\'" + @year + "' AND mm='"+@month+"\'"
  end

  def getsumms
  	@index = 1

  	if params[:mm] != nil
  		@month = params[:mm]
  	else
  		if DateTime.now.month.to_s.size == 1
			@month = "0"+DateTime.now.month.to_s
		else
			@month = DateTime.now.month.to_s
		end
	end

	if params[:mm] != nil
  		@year = params[:yy]
  	else
		@year =  DateTime.now.year.to_s
	end

	if params[:query] != nil
		if params[:number] != nil
		@ids = Contract.where(params[:query].to_s).where("title LIKE '"+params[:number].to_s+"%'").order('title ASC')
		else
		@ids = Contract.where(params[:query].to_s).order('title ASC')	
		end
	else
		@ids = Contract.where("pgid='1' AND title LIKE '04-%'").order('title ASC')
	end
	@wherestring = "yy=\'" + @year + "' AND mm='"+@month+"\'"
  end
end
