# coding: utf-8
class InetService < ActiveRecord::Base
  self.table_name = "inet_serv_14"
  belongs_to :contract, class_name: 'Contract'#, foreign_key: 'contractId'
  has_many :inet_resource_subscriptions, class_name: 'InetResourceSubscription', foreign_key: 'subscriberId'
end