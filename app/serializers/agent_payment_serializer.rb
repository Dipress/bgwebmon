class AgentPaymentSerializer < ActiveModel::Serializer
  #extend ActiveModel::Translation
  attributes :id, :value, :created_at, :managed_at, :user, :manager, :contract, :class_name, :status, :confirmation, :confirmation_at, :confirmed_by

  attribute :text#, key: :comment

  #has_one :user
  #has_one :manager
  #has_one :contract

  def created_at
    I18n.l object.created_at, format: :long
  end

  def status
    object.manager_id ? true : false
  end

  def confirmation
    if object.manager_id.nil?
      true
    elsif object.confirmation_id.nil?
      false
    else
      true
    end
  end

  def managed_at
    object.managed_at ? I18n.l(object.managed_at, format: :long) : ""
  end

  def confirmation_at
    object.confirmation_at ? I18n.l(object.confirmation_at, format: :long) : ""
  end

  def class_name
    if object.manager_id.nil?
      'white'
    elsif object.confirmation_id.nil?
      'green'
    else
      'blue'
    end
  end

  def user
    user = object.user
    user ? user.name : ""
  end

  def manager
    manager = object.manager
    manager ? manager.name : ""
  end 

  def confirmed_by
    confirmation = object.confirmation
    confirmation ? confirmation.name : ""
  end 

  def contract
    contract = object.contract
    contract ? "#{contract.title} - #{contract.comment}" : ""
  end
end