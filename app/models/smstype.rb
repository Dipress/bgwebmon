# coding: utf-8
class Smstype
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :smses 
  
  field :title

  validates :title, presence: true
end
