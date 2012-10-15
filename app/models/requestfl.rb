# coding: utf-8
class Requestfl < ActiveRecord::Base
 
  belongs_to :requeststatus
  belongs_to :user
  belongs_to :tariffplan

  attr_accessor :pd
#  attr_protected :requeststatus_id, :created_at, :updated_at
  attr_accessible :description, :fio, :adress_post, :adress_connection, 
  				  :adress_connection, :latlng_connection, :email, :telephone, :in, 
            :pasport, :pasport_authority, :pasport_date, :payment_form, :ip, 
            :user_id, :technology, :node, :tariffplan_id, :pd, :login, :password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  telephone_regex = /\A\+[0-9]{12}\z/i
  pd_regex = /\A[0-3][0-9]\.[0-1][0-9]\.[0-9]{4}\z/i

  OB="обязательное поле"   

  validates :fio, :presence => {:message => "ФИО - #{OB}"},
            :length =>{:within => 1..70,
                       :message => 'ФИО - поле должно содержать от 1 до 70 символов'}
  validates :adress_post, :presence => {:message => "Почтовый адресс - #{OB}"},
            	 		  :length =>{:maximum => 150,
                       		   		 :message => 'Почтовый адресс - должен содержать до 150 символов'}
  validates :adress_connection, :presence => {:message => "Адресс - #{OB}"},
            	 			    :length =>{:maximum => 150,
                       		   			   :message => 'Адресс - подключения должен содержать до 100 символов'}
  validates :latlng_connection, :presence => {:message => "Координаты - #{OB}"},
            	 			    :length =>{:maximum => 100,
                       		   			   :message => 'Координаты - должны содержать до 100 символов'}
#  validates :email, :format => {:with => email_regex, 
#                              :message => 'Email - неверный формат поля (mail@example.com)'}
  validates :telephone, :presence => {:message => "Телефон - #{OB}"},
            :format => {:with => telephone_regex, 
                        :message => 'Телефон - неверный формат поля (+380507339877)'}
  validates :in, :presence => {:message => "Идентификационный код - #{OB}"},
            	 	:length =>{:maximum => 30,
                       		   :message => 'Идентификационный код - должен содержать до 30 символов'}
  validates :pasport, :presence => {:message => "Паспорт серия/номер - #{OB}"},
            	 	  :length =>{:maximum => 20,
                       		     :message => 'Паспорт серия/номер - долженj содержать до 20 символов'}
  validates :pasport_authority, :presence => {:message => "Кем выдан паспорт - #{OB}"},
            	 				:length =>{:maximum => 60,
                       		   			   :message => 'Кем выдан паспорт - должно содержать до 60 символов'}
  validates :pd, :presence => {:message => "Дата выдачи паспорта - #{OB}"},
            :format => {:with => pd_regex, 
                        :message => 'Дата выдачи паспорта - неверный формат поля (dd.mm.yyyy)'}
  validates :payment_form, :presence => {:message => "Форма оплаты - #{OB}"}, 
                      :numericality => { :only_integer => true, 
                      					 :message => "Форма оплаты - может быть только числом"}
  validates :ip, :presence => {:message => "IP - #{OB}"},
            	 :length =>{:within => 9..15,
                       		:message => 'IP - должен содержать от 9 до 15 символов'}
  validates :login, :presence => {:message => "Логин - #{OB}"},
               :length =>{:within => 3..15,
                          :message => 'Логин - должен содержать от 3 до 15 символов'}
  validates :password, :presence => {:message => "Пароль - #{OB}"},
               :length =>{:within => 3..15,
                          :message => 'Пароль - должен содержать от 3 до 15 символов'}
#  validates :user_id, :presence => {:message => "Создатель - #{OB}"}, 
#                      :numericality => { :only_integer => true, 
#                      					 :message => "Создатель - поле может быть только числом"}
  validates :technology, :presence => {:message => "Технология передачи даных - #{OB}"}, 
                      :numericality => { :only_integer => true, 
                      					 :message => "Технология передачи даных - может быть только числом"}
  validates :node, :presence => {:message => "Точка подключения - #{OB}"}, 
                      :numericality => { :only_integer => true, 
                      					 :message => "Точка подключения - может быть только числом"}
  validates :tariffplan_id, :presence => {:message => "Тарифный план - #{OB}"}, 
                      :numericality => { :only_integer => true, 
                      					 :message => "Тарифный план - может быть только числом"}
  before_save :pasportdate

  def pasportdate
    self.pasport_date = Date.parse(pd) if new_record?
  end

end
