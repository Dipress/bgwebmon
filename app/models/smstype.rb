# coding: utf-8
class Smstype
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :smses 
  
  field :title
  
  auto_increment :sequence, seed: 0
  validates :title, presence: true
end
