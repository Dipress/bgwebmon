# coding: utf-8
require 'spec_helper'

describe Bgmodule do
	before(:each) do
		@bgmodule = Factory(:bgmodule)
		@contract = Factory(:contract)
		@contract_module = Factory(:contract_module, :contract => @contract, :bgmodule => @bgmodule)
	end

	describe "Отношения" do
		describe ".contract_module" do
			it "наличие отношения" do
				@bgmodule.should respond_to(:contract_modules)
			end
			it "@bgmodule.contract_module == @contract_module" do
				@bgmodule.contract_modules[0].should == @contract_module
			end
		end
		describe ".contracts" do
			it "наличие отношения" do
				@bgmodule.should respond_to(:contracts)
			end
			it ".contracts[0] == @contract_module" do
				@bgmodule.contracts[0].should == @contract
			end
		end
	end
end