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

	it "поле rx должно быть числом" do
		[nil, "sss"].each do |w|
			wong_format_rx = Factory(:contract)
			wong_format_rx.rx = w
			wong_format_rx.should_not be_valid
		end
	end

	it "поле tx должно быть числом" do
		[nil, "sss"].each do |w|
			wong_format_tx = Factory(:contract)
			wong_format_tx.tx = w
			wong_format_tx.should_not be_valid
		end
	end

	describe "поле online" do
  		it "не может быть nil" do
  			no_online_user = Factory(:contract)
  			no_online_user.online = nil
  			no_online_user.should_not be_valid
  		end
  	end

	describe "Отношения @contract" do
		before(:each) do
			@bgmodule = Factory(:bgmodule)
			@contract_module = Factory(:contract_module, :contract => @contract, :bgmodule => @bgmodule)
			@dialuplogin = Factory(:dialuplogin, :contract => @contract)
			@dialuperror = Factory(:dialuperror, :contract => @contract, :dialuplogin => @dialuplogins)
			@dialupalias = Factory(:dialupalias, :dialuplogin => @dialuplogin)
			@dialupip = Factory(:dialupip, :dialuplogin => @dialuplogin)
		end
		describe ".dialuplogins" do
			it "наличие отношения" do
				@contract.should respond_to(:dialuplogins)
			end
			it "[0] == @dialuplogin" do
				@contract.dialuplogins[0].should == @dialuplogin
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