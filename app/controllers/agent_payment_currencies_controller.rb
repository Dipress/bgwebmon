# coding: utf-8
class AgentPaymentCurrenciesController < ApplicationController
	before_filter :checklogedin
	before_filter :sadmin
	before_filter :ip_check


	def index
		@user = current_user()
		@currency = AgentPaymentCurrency.all
	end

	def show
		@user = current_user()
		@currency = AgentPaymentCurrency.find(params[:id])
	end

	def new
		@user = current_user()
		@currency = AgentPaymentCurrency.new
	end

	def create
		@user = current_user()
		@currency = AgentPaymentCurrency.new(params[:agent_payment_currency])
		if @currency.save
			redirect_to agent_payment_currency_path
		else
			render :new
		end
	end

	def edit
		@user = current_user()
		@currency = AgentPaymentCurrency.find(params[:id])
	end

	def update
		@user = current_user()
		@currency = AgentPaymentCurrency.find(params[:id])
		if @currency.update_attributes(params[:agent_payment_currency])
			redirect_to agent_payment_currency_path
		else
			render :edit
		end
	end

	def delete
		@user = current_user()
		@currency = AgentPaymentCurrency.find(params[:id])
	end
	def destroy
		@user = current_user()
		@currency = AgentPaymentCurrency.find(params[:id])
		@currency.destroy
		redirect_to agent_payment_currency_path
	end
end
