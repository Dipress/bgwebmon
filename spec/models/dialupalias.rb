# coding: utf-8
require 'spec_helper'

describe Dialupalias do
	describe "Ассоциации" do
		before(:each) do
			@contract = Factory(:contract)
			@dialupalias = Factory(:dialupalias)
			@dialuplogin = Factory(:dialuplogin, :contract => @contract, :dialuplogin => @dialuplogin)
		end
		describe ".dialuplogin" do
			it "наличие отношения" do
				@dialupalias.should respond_to(:dialuplogins)
			end
			it ".dialuplogin == @dialuplogin" do
				@dialupalias.dialuplogins[0].should == @dialuplogin
			end
		end
		describe ".contract" do
			it "наличие отношения" do
				@dialupalias.should respond_to(:contract)
			end
			it ".contract == @contract" do
				@dialupalias.contract.should == @contract
			end
		end
	end
end