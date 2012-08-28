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