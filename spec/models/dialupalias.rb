# coding: utf-8
require 'spec_helper'

describe Dialupalias do
	describe "Ассоциации" do
		before(:each) do
			@contract = Factory(:contract)
			@dialuplogin = Factory(:dialuplogin, :contract => @contract)
			@dialupalias = Factory(:dialupalias, :dialuplogin => @dialuplogin)
		end
		describe "@dialupalias.dialuplogin" do
			it "наличие ассоциации" do
				@dialupalias.should respond_to(:dialuplogin)
			end
			it "@dialupalias.dialuplogin == @dialuplogin" do
				@dialupalias.dialuplogin.should == @dialuplogin
			end
		end
		describe "@dialupalias.contract" do
			it "наличие ассоциации" do
				@dialupalias.should respond_to(:contract)
			end
			it "@dialupalias.contract == @contract" do
				@dialupalias.contract.should == @contract
			end
		end
	end
end