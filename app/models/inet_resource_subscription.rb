class InetResourceSubscription < ActiveRecord::Base
  self.table_name = "inv_ip_resource_subscription_14"
  #attr_accessible :subscriberId, :ipResourceId, :addressFrom, :addressTo, :dateFrom, :dateTo, :subscriberTitle
  belongs_to :inet_service, class_name: 'InetService'#, foreign_key: 'ipResourceSubscriptionId'

  def human_ip
    addressFrom.bytes.to_a.join('.')
  end
end
