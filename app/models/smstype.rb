# coding: utf-8
class Smstype < ActiveRecord::Base
  has_many :smses 
  attr_accessible :title

  validates :title, :presence => {:message => "Заголовок обязателен"},
  				    :length => {:maximum => 64,
  				    		    :message => "Заголовок не может быть больше 64 символов"}
end
