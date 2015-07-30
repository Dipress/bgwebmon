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
  #telephone_regex = /\A\+[0-9]{12}\z/i
  telephone_regex = /\A\d{10}\z/i
  pd_regex = /\A[0-3][0-9]\.[0-1][0-9]\.[0-9]{4}\z/i

  OB="обязательное поле"

  validates :fio, presence: { message: "ФИО - #{OB}"}, length: { within: 1..70, message: I18n.t("activerecord.validations.fio")}
  validates :adress_post, presence: { message: "Почтовый адрес - #{OB}"}, length: { maximum: 200, message: I18n.t("activerecord.validations.adress_post")}
  validates :adress_connection, presence: { message: "Адресс - #{OB}"},length: { maximum: 200, message: I18n.t("activerecord.validations.adress_connection")}
  #validates :latlng_connection, presence: { message: "Координаты - #{OB}"}, length: { maximum: 100, message: I18n.t("activerecord.validations.latlng_connection")}
  validates :telephone, presence: { message: "Телефон - #{OB}"}, format: { with: telephone_regex, message: I18n.t("activerecord.validations.telephone")}
  validates :in, presence: { message: "Идентификационный код - #{OB}"}, length: { maximum: 30, message: I18n.t("activerecord.validations.in")}
  validates :pasport, presence: { message: "Паспорт серия/номер - #{OB}"}, length: { maximum: 20, message: I18n.t("activerecord.validations.pasport")}
  validates :pasport_authority, presence: { message: "Кем выдан паспорт - #{OB}"}, length: { maximum: 90, message: I18n.t("activerecord.validations.pasport_authority")}
  validates :pd, presence: { message: "Дата выдачи паспорта - #{OB}"}, format: { with: pd_regex, message: I18n.t("activerecord.validations.pd")}
  validates :payment_form, presence: { message: "Форма оплаты - #{OB}"}, numericality: { only_integer: true, message: I18n.t("activerecord.validations.payment_form")}
  validates :ip, length: { within: 7..15, message: 'IP - должен содержать от 7 до 15 символов'}, allow_blank: true
  validates :login, presence: { message: "Логин - #{OB}"}, length: { within: 3..15, message: I18n.t("activerecord.validations.login")}
  validates :password, presence: { message: "Пароль - #{OB}"}, length: { within: 3..15, message: I18n.t("activerecord.validations.password")}
  validates :technology, presence: { message: "Технология передачи даных - #{OB}"}, numericality: { only_integer: true, message: I18n.t("activerecord.validations.technology")}
  validates :node, presence: { message: "Точка подключения - #{OB}"}, numericality: { only_integer: true, message: I18n.t("activerecord.validations.node")}
  validates :tariffplan_id, presence: { message: "Тарифный план - #{OB}"}, numericality: { only_integer: true,  message: I18n.t("activerecord.validations.tariffplan_id")}
  before_save :pasportdate
  before_update :pasportdate

  def pasportdate
    self.pasport_date = Date.parse(pd) if new_record?
  end

end
