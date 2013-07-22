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
        one_day = (b.summa3 / day)
        #Стоимость пяти дней
        five_days = 5 * one_day
        #Если осталось на Х дней
        if balance < five_days && balance > 0
          #Осталось средств на Х дней
          days_left = balance / one_day
          dd = days_left.ceil
          dd = 1 if dd == 0
          s = Smses.where(["smstype_id=? AND created_at>=? AND contract_id=?", 1, (timenow - 4.day).strftime("%Y-%m-%d %H:%M"), contract.id]).first
          phone = contract.mobile_phone
          if s.nil? && phone
            Sms.create! contract_id: contract.id, title: contract.title, comment: contract.comment, text: I18n.t('ru.sms.few_days', days: I18n.t(:days, count: dd)), smstype_id: 1, phone: phone
          end
        #Если баланс 0, но меньше лимита
        elsif balance < 0 && balance - one_day > contract.closesumma.to_f
          s = contract.smses.where(["smstype_id=? AND created_at>=? AND contract_id=?", 2, (timenow - 5.day).strftime("%Y-%m-%d %H:%M"), contract.id]).first
          phone = contract.mobile_phone
          if s.nil? && phone
            Sms.create! contract_id: contract.id, title: contract.title, comment: contract.comment, text: I18n.t('ru.sms.exhausted'), smstype_id: 2, phone: contract.phone
          end
        elsif balance == 0 && contract.closesumma.to_i == 0
          s = contract.smses.where(["smstype_id=? AND created_at>=? AND contract_id=?", 3, (timenow - 5.day).strftime("%Y-%m-%d %H:%M"), contract.id]).first
          phone = contract.mobile_phone
          if s.nil? && phone
            Sms.create! contract_id: contract.id, title: contract.title, comment: contract.comment, text: I18n.t('ru.sms.exhausted_limit'), smstype_id: 3, phone: contract.phone
          end
        end
      end
    end
  end
end
