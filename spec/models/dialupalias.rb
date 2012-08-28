# coding: utf-8
require 'spec_helper'

describe Dialupalias do
	describe "Отношения @dialupalias" do
		before(:each) do
			@contract = Factory(:contract)
			@dialuplogin = Factory(:dialuplogin, :contract => @contract)
			@dialuperror = Factory(:dialuperror, :contract => @contract, :dialuplogin => @dialuplogin)
			@dialupalias = Factory(:dialupalias, :dialuplogin => @dialuplogin)
		end
		describe ".dialuplogin" do
			it "наличие отношения" do
				@dialupalias.should respond_to(:dialuplogins)
			end
			it " == @dialuplogin" do
				@dialupalias.dialuplogins[0].should == @dialuplogin
			end
		end
		describe ".contract" do
			it "наличие отношения" do
				@dialupalias.should respond_to(:contract)
			end
			it " == @contract" do
				@dialupalias.contract.should == @contract
			end
		end
		describe ".dialuperrors" do
			it "наличие отношения" do
				@dialupalias.should respond_to(:dialuperrors)
			end
			it "[0] == @contract" do
				@dialupalias.dialuperrors[0].should == @dialuperror
			end
		end
	end
end