# coding: utf-8
class ContractSerializer < ActiveModel::Serializer
  attributes :id, :title, :comment, :bs, :closesumma, :balance

  has_many :dialuplogins
  has_many :inet_services

  def closesumma
    object.closesumma.to_s
  end

  def bs
    bc = object.contract_parameter_type7_values.where(pid: 54).last
    bc.nil? ? 'Базовая станция не выбрана' : bc.title
  end

  def balance
    object.current_balance
  end
end
