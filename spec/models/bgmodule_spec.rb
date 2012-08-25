# coding: utf-8
require 'spec_helper'

describe Bgmodule do
	before(:each) do
		@bgmodule = Factory(:bgmodule)
		@contract = Factory(:contract)
		@contract_module = Factory(:contract_module, :contract => @contract, :bgmodule => @bgmodule)
	end

	describe "Ассоциации" do
		describe "@bgmodule.contract_module" do
			it "наличие ассоциации" do
				@bgmodule.should respond_to(:contract_modules)
			end
			it "@bgmodule.contract_module == @contract_module" do
				@bgmodule.contract_modules[0].should == @contract_module
			end
		end
		describe "@bgmodule.contracts" do
			it "наличие ассоциации" do
				@bgmodule.should respond_to(:contracts)
			end
			it "@bgmodule.contracts[0] == @contract_module" do
				@bgmodule.contracts[0].should == @contract
			end
		end
	end
end