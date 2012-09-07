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
		end
		describe ".dialuplogins" do
			it "наличие отношения" do
				@contract.should respond_to(:dialuplogins)
			end
			it "[0] == @dialuplogin" do
				@contract.dialuplogins[0].should == @dialuplogin
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