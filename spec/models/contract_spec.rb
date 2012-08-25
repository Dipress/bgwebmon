# coding: utf-8
require 'spec_helper'

describe Contract do
	before(:each) do
		@contract = Factory(:contract)
	end

	it "должен содержать поля миграции rxtxonline" do
		@contract.should respond_to(:online)
		@contract.should respond_to(:rx)
		@contract.should respond_to(:rx)
	end

	it "поля созданные миграцией rxtxonline должны принимать default значения" do
		@contract.online.should equal(false)
		@contract.rx.should equal(0)
		@contract.tx.should equal(0)
	end

	describe "Ассоциации" do
		before(:each) do
			@dialuplogin = Factory(:dialuplogin, :contract => @contract)
			@dialupalias = Factory(:dialupalias, :dialuplogin => @dialuplogin)
			@dialupip = Factory(:dialupip, :dialuplogin => @dialuplogin)
		end
		describe "@contract.dialuplogin" do
			it "наличие ассоциации" do
				@contract.should respond_to(:dialuplogin)
			end
			it "@contract.dialuplogin == @dialuplogin" do
				@contract.dialuplogin.should == @dialuplogin
			end
		end
		describe "@contract.dialupalias" do
			it "наличие ассоциации" do
				@contract.should respond_to(:dialupalias)
			end
			it "@contract.dialupalias == @dialuplogin.dialupalias" do
				@contract.dialupalias.should == @dialuplogin.dialupalias
			end
		end
		describe "@contract.dialupip" do
			it "наличие ассоциации" do
				@contract.should respond_to(:dialupip)
			end
			it "@contract.dialupip == @dialuplogin.dialupip" do
				@contract.dialupip.should == @dialuplogin.dialupip
			end
		end
	end
end