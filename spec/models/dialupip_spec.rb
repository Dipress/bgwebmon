# coding: utf-8
require 'spec_helper'

describe Dialupip do
	describe "Отношения" do
		before(:each) do
			@contract = Factory(:contract)
			@dialuplogin = Factory(:dialuplogin, :contract => @contract)
			@dialupalias = Factory(:dialupalias, :dialuplogin => @dialuplogin)
			@dialupip = Factory(:dialupip, :dialuplogin => @dialuplogin)
		end
		describe ".dialuplogin" do
			it "наличие отношения" do
				@dialupip.should respond_to(:dialuplogin)
			end
			it ".dialuplogin == @dialuplogin" do
				@dialupip.dialuplogin.should == @dialuplogin
			end
		end
		describe ".contract" do
			it "наличие отношения" do
				@dialupip.should respond_to(:contract)
			end
			it ".contract == @contract" do
				@dialupip.contract.should == @contract
			end
		end
	end
end