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

	describe "Ассоциации" do
		before(:each) do
			@bgmodule = Factory(:bgmodule)
			@contract_module = Factory(:contract_module, :contract => @contract, :bgmodule => @bgmodule)
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
		describe "@contract.contract_module" do
			it "наличие ассоциации" do
				@contract.should respond_to(:contract_module)
			end
			it "@contract.contract_module == @contract_module" do
				@contract.contract_module.should == @contract_module
			end
		end
		describe "@contract.bgmodules" do
			it "наличие ассоциации" do
				@contract.should respond_to(:bgmodules)
			end
			it "@contract.bgmodules == @bgmodule" do
				@contract.bgmodules[0].should == @bgmodule
			end
		end
		describe "@contract.bgmodule" do
			it "наличие ассоциации" do
				@contract.should respond_to(:bgmodules)
			end
			it "@contract.bgmodules[0] == @bgmodule" do
				@contract.bgmodules[0].should == @bgmodule
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