# coding: utf-8
require 'spec_helper'

describe PaymentType do
	before(:each) do
		@contract = Factory(:contract)
		@payment_type = Factory(:payment_type)
		@payment = Factory(:payment, :contract => @contract, :payment_type => @payment_type)
	end

	describe "Отношения @payment_type" do
		describe ".payments" do
			it "наличие отношения" do
				@payment_type.should respond_to(:payments)
			end
			it " == @payment_type" do
				@payment_type.payments[0].should == @payment
			end
		end
	end
end