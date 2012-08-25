# coding: utf-8
require 'spec_helper'

describe ContractModule do
	before(:each) do
		@bgmodule = Factory(:bgmodule)
		@contract = Factory(:contract)
		@contract_module = Factory(:contract_module, :contract => @contract, :bgmodule => @bgmodule)
	end

	describe "Ассоциации" do
		describe "@contract_module.bgmodule" do
			it "наличие ассоциации" do
				@contract_module.should respond_to(:bgmodule)
			end
			it "@contract_module.bgmodule == @bgmodule" do
				@contract_module.bgmodule.should == @bgmodule
			end
		end
		describe "@contract_module.contract" do
			it "наличие ассоциации" do
				@contract_module.should respond_to(:contract)
			end
			it "@contract_module.contract == @contract" do
				@contract_module.contract.should == @contract
			end
		end
	end
end