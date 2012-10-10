# coding: utf-8
class Requeststatus < ActiveRecord::Base

  has_many :requestfls

  attr_accessible :title

  validates :title, :presence => {:message => "Заголовок - обязательное поле"},
   		            :length =>{:within => 5..30,
                       		   :message => 'Заголовок - поле должно содержать от 5 до 30 символов'}

end
