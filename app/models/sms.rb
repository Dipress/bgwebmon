# coding: utf-8
class Sms < ActiveRecord::Base
  belongs_to :contract, :class_name => "Contract", :foreign_key => "cid"
  belongs_to :smstype

  attr_accessible :cid, :smstype_id, :date

  validates :cid, :presence => {:message => "Номер договора обязателен"}
  validates :smstype_id, :presence => {:message => "Тип смс обязателен"}
  validates :date, :presence => {:message => "Дата отправки обязательна"}
end
