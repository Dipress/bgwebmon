class ContractSerializer < ActiveModel::Serializer
  attributes :id, :title, :comment, :bs, :closesumma, :balance#, :partner
  has_many :dialupaliases

  def bs
    bc = object.contract_parameter_type7_values.where(pid: 54).last
    bc.nil? ? nil : bc.title
  end

  def balance
    object.current_balance
  end

  #def partner
  #  partner = object.contract_parameter_type8.last
  #  partner.nil? ? nil : partner.val
  #end
end
