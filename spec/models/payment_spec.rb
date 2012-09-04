# coding: utf-8
require 'spec_helper'

describe Payment do
	before(:each) do
		@contract = Factory(:contract)
		@payment_type = Factory(:payment_type)
		@payment = Factory(:payment, :contract => @contract, :payment_type => @payment_type)
	end

	describe "Отношения @payment" do
		describe ".contract" do
			it "наличие отношения" do
				@payment.should respond_to(:contract)
			end
			it " == @contract" do
				@payment.contract.should == @contract
			end
		end
		describe ".contracts" do
			it "наличие отношения" do
				@payment.should respond_to(:payment_type)
			end
			it " == @payment_type" do
				@payment.payment_type.should == @payment_type
			end
		end
	end
end