# coding: utf-8
require 'spec_helper'

describe Contract do
	describe "Отношения @contract_parameter_type8" do
		before(:each) do
			@contract = Factory(:contract)
			@contract_parameter_type8 = Factory(:contract_parameter_type8, :contract => @contract)
		end
		describe ".contract" do
			it "наличие отношения" do
				@contract_parameter_type8.should respond_to(:contract)
			end			
			it "наличие отношения" do
				@contract_parameter_type8.contract == @contract
			end		
		end
	end
end