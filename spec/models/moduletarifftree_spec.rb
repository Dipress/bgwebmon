# coding: utf-8
require 'spec_helper'

describe Moduletarifftree do
	describe "Отношения @moduletarifftree" do
		before(:each) do
			@contract = Factory(:contract)
			@contracttreelink = Factory(:contracttreelink, :contract => @contract)
			@moduletarifftree = Factory(:moduletarifftree, :contracttreelink => @contracttreelink)
		end
		describe ".contracttreelink" do
			it "наличие отношения" do
				@moduletarifftree.should respond_to(:contracttreelink )
			end
			it "== @contract" do
				@moduletarifftree.contracttreelink.should == @contracttreelink
			end
		end
    end
end