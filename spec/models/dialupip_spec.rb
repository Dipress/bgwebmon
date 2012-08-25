# coding: utf-8
require 'spec_helper'

describe Dialupip do
	describe "Ассоциации" do
		before(:each) do
			@contract = Factory(:contract)
			@dialuplogin = Factory(:dialuplogin, :contract => @contract)
			@dialupip = Factory(:dialupip, :dialuplogin => @dialuplogin)
		end
		describe "@dialupip.dialuplogin" do
			it "наличие ассоциации" do
				@dialupip.should respond_to(:dialuplogin)
			end
			it "@dialupip.dialuplogin == @dialuplogin" do
				@dialupip.dialuplogin.should == @dialuplogin
			end
		end
		describe "@dialupip.contract" do
			it "наличие ассоциации" do
				@dialupip.should respond_to(:contract)
			end
			it "@dialupip.contract == @contract" do
				@dialupip.contract.should == @contract
			end
		end
	end
end