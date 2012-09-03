# coding: utf-8
require 'spec_helper'

# !Внимание 
# warning: redefining `object_id' may cause serious problems
# связано с неудачным названием для поля таблицы, предупреждение можно
# проигнорировать если нет нужды в записи или обновлении таблицы через модель

describe Dialuplogin do
	describe "Отношения @dialuplogin" do
		before(:each) do
			@contract = Factory(:contract)
			@dialuplogin = Factory(:dialuplogin, :contract => @contract)
			@dialuperror = Factory(:dialuperror, :contract => @contract, :dialuplogin => @dialuplogin)
			@dialupalias = Factory(:dialupalias, :dialuplogin => @dialuplogin)
			@dialupip = Factory(:dialupip, :dialuplogin => @dialuplogin)
		end
		it "должен содержать поля миграции rxtxonline" do
			@dialuplogin.should respond_to(:online)
			@dialuplogin.should respond_to(:rx)
			@dialuplogin.should respond_to(:rx)
		end

		it "поля созданные миграцией rxtxonline должны принимать default значения" do
			@dialuplogin.online.should equal(false)
			@dialuplogin.rx.should equal(0)
			@dialuplogin.tx.should equal(0)
		end

		it "поле rx должно быть числом" do
			[nil, "sss"].each do |w|
				wong_format_rx = Factory(:dialuplogin)
				wong_format_rx.rx = w
				wong_format_rx.should_not be_valid
			end
		end

		it "поле tx должно быть числом" do
			[nil, "sss"].each do |w|
				wong_format_tx = Factory(:dialuplogin)
				wong_format_tx.tx = w
				wong_format_tx.should_not be_valid
			end
		end

		describe "поле online" do
  			it "не может быть nil" do
  				no_online_user = Factory(:dialuplogin)
  				no_online_user.online = nil
  				no_online_user.should_not be_valid
  			end
  		end
  		
		describe ".dialupalias" do
			it "наличие отношения" do
				@dialuplogin.should respond_to(:dialupalias)
			end
			it " == @dialupalias" do
				@dialuplogin.dialupalias.should == @dialupalias
			end
		end
		describe ".dialupip" do
			it "наличие отношения" do
				@dialuplogin.should respond_to(:dialupip)
			end
			it " == @dialupip" do
				@dialuplogin.dialupip.should == @dialupip
			end
		end
		describe ".contract" do
			it "наличие отношения" do
				@dialuplogin.should respond_to(:contract)
			end
			it " == @contract" do
				@dialuplogin.contract.should == @contract
			end
		end
		describe ".dialuperror" do
			it "наличие отношения" do
				@dialuplogin.should respond_to(:dialuperrors)
			end
			it " == @dialuperror" do
				@dialuplogin.dialuperrors[0].should == @dialuperror
			end
		end
	end
end