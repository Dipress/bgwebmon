# coding: utf-8
class InetServiceSerializer < ActiveModel::Serializer
  attributes :id, :login

  has_many :inet_resource_subscriptions
end