# coding: utf-8
class Tstatus < ActiveRecord::Base
  attr_accessible :title

  has_many :tasks

  validates :title , :presence => { :message => "Заголовок - обязательное поле" },
            :length => { :within => 1..120,
                         :message => 'Заголовок - поле должно содержать от 1 до 120 символов' }
end
