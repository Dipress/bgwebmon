# coding: utf-8
class ContractAccount < ActiveRecord::Base
  self.table_name = "contract_account"

  attr_accessible :yy, :mm, :cid, :sid, :summa

  belongs_to :contract, :class_name => 'Contract', :foreign_key => 'cid'

  def self.operatings_array(cid, mm, yy)
    array = []
    id = Contract.find(cid)
    id.contract_accounts.where("cid='#{cid}' and mm='#{mm - 1}' and yy='#{yy}'").each do |co|
      array << sprintf('%.02f',(co.summa))
    end
    array
  end
end