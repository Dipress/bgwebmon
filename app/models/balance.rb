# coding: utf-8
class Balance < ActiveRecord::Base
  self.table_name =  "contract_balance"

  attr_accessible :yy, :mm, :cid, :summa1, :summa2, :summa3, :summa4

  belongs_to :contract, :class_name => 'Contract', :foreign_key => 'cid'

  def self.balance(cid,mm,yy)
    b = self.by_cmy(cid,mm,yy)
  end

  def self.operating(cid, mm, yy)
    if mm.eql?(1)
	 balance = Balance.where("cid='#{cid}' and mm='#{mm + 11}' and yy='#{yy - 1}'")[0]
      	 return sprintf('%.02f',(balance.summa3)).gsub(".", ",")
    else if balance.nil?
      return 0
    else
      balance = Balance.where("cid='#{cid}' and mm='#{mm - 1}' and yy='#{yy}'").limit(1)[0]
      return sprintf('%.02f',(balance.summa3)).gsub(".", ",")
    end
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
