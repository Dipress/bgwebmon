class InetResourceSubscription < ActiveRecord::Base
  self.table_name = "inv_ip_resource_subscription_14"
  belongs_to :inet_service, class_name: 'InetService', foreign_key: 'subscriberId'

  attr_accessible :subscriberId, :ipResourceId, :addressFrom, :addressTo, :dateFrom, :dateTo, :subscriberTitle
end
