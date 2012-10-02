# coding: utf-8
require 'spec_helper'

describe Contract do
	describe "Отношения @contract_parameter_type7_value" do
		before(:each) do
			@contract = Factory(:contract)
			@contracttreelink = Factory(:contracttreelink, :contract => @contract)
			@contract_parameter_type7_value = Factory(:contract_parameter_type7_value)
			@contract_parameter_type7 = Factory(:contract_parameter_type7, :contract => @contract, :contract_parameter_type7_value => @contract_parameter_type7_value)
		end
		describe ".contract_parameter_type7" do
			it "наличие отношения" do
				@contract_parameter_type7_value.should respond_to(:contract_parameter_type7)
			end			
			it "наличие отношения" do
				@contract_parameter_type7_value.contract_parameter_type7 == @contract_parameter_type7
			end		
		end
		describe ".contract" do
			it "наличие отношения" do
				@contract_parameter_type7_value.should respond_to(:contracts)
			end			
			it "наличие отношения" do
				@contract_parameter_type7_value.contracts == @contracts
			end		
		end
	end
end