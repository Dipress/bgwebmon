# coding: utf-8
class Sms
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :smstype, index: true

  field :contract_id, type: Integer
  field :phone
  field :title
  field :comment
  field :text
  field :status

  validates :smstype_id, :contract_id, :phone, :title, :comment, :text, presence: true


  def self.send_debt_messages
    time = Time.now
    Flag.where(pid: 46, val: 1).each do |f|
      contract = f.contract
      b = contract.balances.where(yy: time.year, mm: time.month).first
      if b != nil && contract.status == 0
        balance = b.summa1 + b.summa2 - b.summa3 - b.summa4
        #Стоимость одного дня
        one_day = (b.summa3 / time.day)
        #Стоимость пяти дней
        five_days = 5 * one_day
        #Если осталось на Х дней

        if balance < five_days && balance > 0
          #Осталось средств на Х дней
          days_left = balance / one_day
          dd = days_left.ceil
          dd = 1 if dd == 0
          s = Sms.where(smstype_id: 1, :created_at.gte => (time - 1.day), contract_id: contract.id).first
          phone = contract.mobile_phone
          if s.nil? && !phone.nil? && (dd==1||dd==5)
            Sms.create! contract_id: contract.id, title: contract.title, comment: contract.comment, text: I18n.t('sms.few_days', days: I18n.t(:days, count: dd)), smstype_id: 1, phone: phone
          end
        #Если баланс 0, но меньше лимита
        elsif balance < 0 && balance - one_day > contract.closesumma.to_f
          limit_days = contract.closesumma.to_f / one_day
          if (4..5).include? limit_days
            s = Sms.where(smstype_id: 2, :created_at.gte => (time - 5.day), contract_id: contract.id).first
            phone = contract.mobile_phone
            if s.nil? && !phone.nil?
              Sms.create! contract_id: contract.id, title: contract.title, comment: contract.comment, text: I18n.t('sms.exhausted'), smstype_id: 2, phone: phone
            end
          end
        #elsif balance == 0 && contract.closesumma.to_i == 0
        #  s = Sms.where(smstype_id: 3, :created_at.gte => (time - 5.day), contract_id: contract.id).first
        #  phone = contract.mobile_phone
        #  if s.nil? && !phone.nil?
        #    Sms.create! contract_id: contract.id, title: contract.title, comment: contract.comment, text: I18n.t('sms.exhausted_limit'), smstype_id: 3, phone: contract.phone
        #  end
        end
      end
    end
  end

end