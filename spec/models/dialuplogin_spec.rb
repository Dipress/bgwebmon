# coding: utf-8
require 'spec_helper'

# !Внимание 
# warning: redefining `object_id' may cause serious problems
# связано с неудачным названием для поля таблицы, предупреждение можно
# проигнорировать если нет нужды в записи или обновлении таблицы через модель

describe Dialuplogin do
	describe "Отношения" do
		before(:each) do
			@contract = Factory(:contract)
			@dialuplogin = Factory(:dialuplogin, :contract => @contract)
			@dialupalias = Factory(:dialupalias, :dialuplogin => @dialuplogin)
			@dialupip = Factory(:dialupip, :dialuplogin => @dialuplogin)
		end
		describe ".dialupalias" do
			it "наличие отношения" do
				@dialuplogin.should respond_to(:dialupalias)
			end
			it ".dialupalias == @dialupalias" do
				@dialuplogin.dialupalias.should == @dialupalias
			end
		end
		describe ".dialupip" do
			it "наличие отношения" do
				@dialuplogin.should respond_to(:dialupip)
			end
			it ".dialupip == @dialupip" do
				@dialuplogin.dialupip.should == @dialupip
			end
		end
		describe ".contract" do
			it "наличие отношения" do
				@dialuplogin.should respond_to(:contract)
			end
			it ".contract == @contract" do
				@dialuplogin.contract.should == @contract
			end
		end
	end
end