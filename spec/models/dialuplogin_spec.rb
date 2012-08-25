# coding: utf-8
require 'spec_helper'

# !Внимание 
# warning: redefining `object_id' may cause serious problems
# связано с неудачным названием для поля таблицы, предупреждение можно
# проигнорировать если нет нужды в записи или обновлении таблицы через модель

describe Contract do
	describe "Ассоциации" do
		before(:each) do
			@contract = Factory(:contract)
			@dialuplogin = Factory(:dialuplogin, :contract => @contract)
			@dialupalias = Factory(:dialupalias, :dialuplogin => @dialuplogin)
			@dialupip = Factory(:dialupip, :dialuplogin => @dialuplogin)
		end
		describe "@dialuplogin.dialupalias" do
			it "наличие ассоциации" do
				@dialuplogin.should respond_to(:dialupalias)
			end
			it "@dialuplogin.dialupalias == @dialupalias" do
				@dialuplogin.dialupalias.should == @dialupalias
			end
		end
		describe "@dialuplogin.dialupip" do
			it "наличие ассоциации" do
				@dialuplogin.should respond_to(:dialupip)
			end
			it "@dialuplogin.dialupip == @dialupip" do
				@dialuplogin.dialupip.should == @dialupip
			end
		end
		describe "@dialuplogin.contract" do
			it "наличие ассоциации" do
				@dialuplogin.should respond_to(:contract)
			end
			it "@dialuplogin.contract == @contract" do
				@dialuplogin.contract.should == @contract
			end
		end
	end
end