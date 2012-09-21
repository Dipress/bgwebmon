# coding: utf-8
require 'spec_helper'

describe Contracttreelink do
	describe "Отношения @contracttreelink" do
		before(:each) do
			@contract = Factory(:contract)
			@contracttreelink = Factory(:contracttreelink, :contract => @contract)
			@moduletarifftree = Factory(:moduletarifftree, :contracttreelink => @contracttreelink)
		end
		describe ".contract" do
			it "наличие отношения" do
				@contracttreelink.should respond_to(:contract)
			end
			it "== @contract" do
				@contracttreelink.contract.should == @contract
			end
		end
		describe ".moduletarifftrees" do
			it "наличие отношения" do
				@contracttreelink.should respond_to(:moduletarifftrees)
			end
			it "== @contract" do
				@contracttreelink.moduletarifftrees[0].should == @moduletarifftree
			end
		end
    end
end