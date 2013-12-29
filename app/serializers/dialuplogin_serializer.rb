# coding: utf-8
class DialuploginSerializer < ActiveModel::Serializer
  attributes :id

  has_one :dialupip
  has_one :dialupalias
end