# coding: utf-8
class PaymentTasks

  def charge_added payment
    phone = payment.contract.phones.where(["pid=?", 14])[0]
    unless phone.nil?
      phone = "+380" + phone.value.gsub(/\W/,"").match(/[0-9]{9}$/).to_s
      #Gnokii.send "Плтаеж на сумму #{payment.value}грн. обрабатывается, Крыминфоком", phone
    end
    Gnokii.send "Поступил платеж от представителя.", "+3804247682"
  end

  def payment_processed payment
    phone = payment.contract.phones.where(["pid=?", 14])[0]
    unless phone.nil?
      phone = "+380" + phone.value.gsub(/\W/,"").match(/[0-9]{9}$/).to_s
      Gnokii.send "Платеж на сумму #{payment.value}.00 руб. занесен, Крыминфоком", phone
    end
  end

  handle_asynchronously :charge_added, priority: 2
  handle_asynchronously :payment_processed, priority: 3
end

class Gnokii

  def self.send sms, phone
    if Gnokii.checkmobile(phone)
      `echo "#{sms}" | /etc/sms_creator.sh -e "#{phone}"`
    end
  end

  def self.checkmobile phone
    array = %w[\+38050 \+38066 \+38095 \+38099 \+38067 \+38096 \+38097 \+38098 \+38063 \+38093 \+38068 \+38091 \+38092]
    mobilecheck = false
    array.each{|m| mobilecheck = true if phone =~ /^#{m}/}
    return mobilecheck
  end
end