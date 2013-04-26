class AgentPaymentSerializer < ActiveModel::Serializer
  #extend ActiveModel::Translation
  attributes :id, :value, :created_at, :managed_at, :user, :manager, :contract, :class_name, :status

  attribute :text#, key: :comment

  #has_one :user
  #has_one :manager
  #has_one :contract

  def created_at
    I18n.l object.created_at
  end

  def status
  	object.manager_id ? true : false
  end

  def managed_at
    object.managed_at ? I18n.l(object.managed_at) : ""
  end

  def class_name
  	object.manager_id ? 'success' : 'info'
  end

  def user
    user = object.user
    user ? user.name : ""
  end

  def manager
    manager = object.manager
    manager ? manager.name : ""
  end 

  def contract
    contract = object.contract
    contract ? "#{contract.title} - #{contract.comment}" : ""
  end
end