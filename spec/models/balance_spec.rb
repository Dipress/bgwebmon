# coding: utf-8
require 'spec_helper'

describe Balance do
	before(:each) do
		@contract = Factory(:contract)
		@balance = Factory(:balance, :contract => @contract)
	end

	describe "Отношения @balance" do
		describe ".contract" do
			it "наличие отношения" do
				@balance.should respond_to(:contract)
			end
			it " == @contract" do
				@balance.contract.should == @contract
			end
		end
	end
end