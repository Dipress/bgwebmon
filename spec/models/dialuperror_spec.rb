# coding: utf-8
require 'spec_helper'

describe Dialuperror do
	describe "Отношения @dialuperror" do
		before(:each) do
			@contract = Factory(:contract)
			@dialuplogin = Factory(:dialuplogin, :contract => @contract)
			@dialuperror = Factory(:dialuperror, :contract => @contract, :dialuplogin => @dialuplogin)
			@dialupalias = Factory(:dialupalias, :dialuplogin => @dialuplogin)
		end
		describe ".dialuplogin" do
			it "наличие отношения" do
				@dialuperror.should respond_to(:dialuplogin)
			end
			it " == @dialuplogin" do
				@dialuperror.dialuplogin.should == @dialuplogin
			end
		end
		describe ".contract" do
			it "наличие отношения" do
				@dialuperror.should respond_to(:contract)
			end
			it " == @contract" do
				@dialuperror.contract.should == @contract
			end
		end
		describe ".dialupalias" do
			it "наличие отношения" do
				@dialuperror.should respond_to(:dialupalias)
			end
			it " == @dialupalias" do
				@dialuperror.dialupalias.should == @dialupalias
			end
		end
	end
end