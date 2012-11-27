# coding: utf-8
class Task < ActiveRecord::Base
  attr_accessible :title, :text, :user_id, :tstatus_id, :take_id, :end_at, :observers, :region

  has_many :tcomments
  belongs_to :tstatus
  belongs_to :user

  has_many :tfiles

  validates :title, :presence => {:message => "Заголовок обязательное поле"},
                   :length =>{:within => 1..120,
                              :message => 'Заголовок - поле должно содержать от 1 до 120 символов'}
  validates :text, :presence => {:message => "Текст - обязательное поле"},
                   :length =>{:within => 1..1000,
                              :message => 'Текст - поле должно содержать от 1 до 1000 символов'}

  validates :observers, :presence => {:message => "Наблюдатели не выбраны"}
end
