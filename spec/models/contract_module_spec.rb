# coding: utf-8
require 'spec_helper'

describe ContractModule do
	before(:each) do
		@bgmodule = Factory(:bgmodule)
		@contract = Factory(:contract)
		@contract_module = Factory(:contract_module, :contract => @contract, :bgmodule => @bgmodule)
	end

	describe "Отношения" do
		describe ".bgmodule" do
			it "наличие отношения" do
				@contract_module.should respond_to(:bgmodule)
			end
			it ".bgmodule == @bgmodule" do
				@contract_module.bgmodule.should == @bgmodule
			end
		end
		describe ".contract" do
			it "наличие отношения" do
				@contract_module.should respond_to(:contract)
			end
			it ".contract == @contract" do
				@contract_module.contract.should == @contract
			end
		end
	end
end