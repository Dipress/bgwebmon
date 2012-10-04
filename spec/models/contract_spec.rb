# coding: utf-8
require 'spec_helper'

describe Contract do
	before(:each) do
		@contract = Factory(:contract)
	end

	describe "Отношения @contract" do
		before(:each) do
			@bgmodule = Factory(:bgmodule)
			@contract_module = Factory(:contract_module, :contract => @contract, :bgmodule => @bgmodule)
			@dialuplogin = Factory(:dialuplogin, :contract => @contract)
			@dialuperror = Factory(:dialuperror, :contract => @contract, :dialuplogin => @dialuplogins)
			@dialupalias = Factory(:dialupalias, :dialuplogin => @dialuplogin)
			@dialupip = Factory(:dialupip, :dialuplogin => @dialuplogin)
			@payment_type = Factory(:payment_type)
			@payment = Factory(:payment, :contract => @contract, :payment_type => @payment_type)
			@balance = Factory(:balance, :contract => @contract)
			@contracttreelink = Factory(:contracttreelink, :contract => @contract)
			@contract_parameter_type7_value = Factory(:contract_parameter_type7_value)
			@contract_parameter_type7 = Factory(:contract_parameter_type7, :contract => @contract, :contract_parameter_type7_value => @contract_parameter_type7_value)
			@contract_parameter_type8 = Factory(:contract_parameter_type8, :contract => @contract)
		end
		describe ".contract_parameter_type8" do
			it "наличие отношения" do
				@contract.should respond_to(:contract_parameter_type8)
			end			
			it "наличие отношения" do
				@contract.contract_parameter_type8[0] == @contract_parameter_type8
			end		
		end
		describe ".contract_parameter_type7" do
			it "наличие отношения" do
				@contract.should respond_to(:contract_parameter_type7)
			end			
			it "наличие отношения" do
				@contract.contract_parameter_type7[0] == @contract_parameter_type7
			end		
		end
		describe ".contract_parameter_type7_values" do
			it "наличие отношения" do
				@contract.should respond_to(:contract_parameter_type7_values)
			end			
			it "наличие отношения" do
				@contract.contract_parameter_type7_values[0] == @contract_parameter_type7_values
			end		
		end
		describe ".dialuplogins" do
			it "наличие отношения" do
				@contract.should respond_to(:dialuplogins)
			end
			it "[0] == @dialuplogin" do
				@contract.dialuplogins[0].should == @dialuplogin
			end
		end
		describe ".contracttreelinks" do
			it "наличие отношения" do
				@contract.should respond_to(:contracttreelinks)
			end
			it "[0] == @contracttreelink" do
				@contract.contracttreelinks[0].should == @contracttreelink
			end
		end
		describe ".balances" do
			it "наличие отношения" do
				@contract.should respond_to(:balances)
			end
		end
		describe ".contract_module" do
			it "наличие отношения" do
				@contract.should respond_to(:contract_modules)
			end
			it "[0] == @contract_module" do
				@contract.contract_modules[0].should == @contract_module
			end
		end
		describe ".payments" do
			it "наличие отношения" do
				@contract.should respond_to(:payments)
			end
			it "[0] == @payment" do
				@contract.payments[0].should == @payment
			end
		end
		describe ".bgmodules" do
			it "наличие отношения" do
				@contract.should respond_to(:bgmodules)
			end
			it "[0]== @bgmodule" do
				@contract.bgmodules[0].should == @bgmodule
			end
		end
		describe ".bgmodule" do
			it "наличие отношения" do
				@contract.should respond_to(:dialuplogins)
			end
			it "[0] == @dialuplogin" do
				@contract.dialuplogins[0].should == @dialuplogin
			end
		end
		describe ".dialupaliases" do
			it "наличие отношения" do
				@contract.should respond_to(:dialupaliases)
			end
			it " == @dialuplogin.dialupalias" do
				@contract.dialupaliases[0].should == @dialuplogin.dialupalias
			end
		end
		describe ".dialupips" do
			it "наличие отношения" do
				@contract.should respond_to(:dialupips)
			end
			it "[0]== @dialuplogin.dialupip" do
				@contract.dialupips[0].should == @dialuplogin.dialupip
			end
		end
		describe ".dialuperrors" do
			it "наличие отношения" do
				@contract.should respond_to(:dialuperrors)
			end
			it "[0]== @dialuperror" do
				@contract.dialuperrors[0].should == @dialuperror
			end
		end
	end
end