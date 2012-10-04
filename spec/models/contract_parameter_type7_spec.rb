# coding: utf-8
require 'spec_helper'

describe Contract do
	describe "Отношения @contract_parameter_type7" do
		before(:each) do
			@contract = Factory(:contract)
			@contract_parameter_type7_value = Factory(:contract_parameter_type7_value)
			@contract_parameter_type7 = Factory(:contract_parameter_type7, :contract => @contract, :contract_parameter_type7_value => @contract_parameter_type7_value)
		end
		describe ".contract_parameter_type7_value" do
			it "наличие отношения" do
				@contract_parameter_type7.should respond_to(:contract_parameter_type7_value)
			end			
			it "наличие отношения" do
				@contract_parameter_type7.contract_parameter_type7_value == @contract_parameter_type7_value
			end		
		end
		describe ".contract" do
			it "наличие отношения" do
				@contract_parameter_type7.should respond_to(:contract)
			end			
			it "наличие отношения" do
				@contract_parameter_type7.contract == @contract
			end		
		end
	end
end