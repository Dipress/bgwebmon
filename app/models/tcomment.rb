# coding: utf-8
class Tcomment < ActiveRecord::Base
  attr_accessible :text, :user_id, :task_id

  belongs_to :task
  belongs_to :user

  #validates :text , :presence => { :message => "Текст - обязательное поле" }, :length => { :within => 1..360, :message => 'Текст - поле должно содержать от 1 до 360 символов' }
end