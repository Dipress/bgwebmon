# coding: utf-8
class Balance < ActiveRecord::Base
  self.table_name =  "contract_balance"
#  self.primary_key = "id"

  belongs_to :contract, :class_name => 'Contract', :foreign_key => 'cid'

  def self.balance(cid,mm,yy)
    b = self.by_cmy(cid,mm,yy)
  end

private

  def self.by_cmy(cid,mm,yy)
	balance = Balance.where("cid='#{cid}' and mm='#{mm}' and yy='#{yy}'").limit(1)[0]  	
	if balance.nil?
    	return "нет"
    else
    	return sprintf('%.02f',(balance.summa1 + balance.summa2 - balance.summa3 - balance.summa4))
    end
  end
end