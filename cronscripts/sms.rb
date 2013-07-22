#!/usr/bin/env ruby
# coding: utf-8
require "#{File.dirname(__FILE__)}/database.rb"
require "#{File.dirname(__FILE__)}/sendemail.rb"

timenow = Time.now
yy = timenow.strftime("%Y")
mm = timenow.strftime("%m") 
day = timenow.day

text = "<h3>Отправлены следующие СМС сообщения:</h3>"

class Smssender
  def self.send(contract, sms, type)
    message = ""
    phone = contract.phones.where(["pid=?", 14])[0]
    if phone.nil?
       message = "<p>Сообщение не отправлено у абонента #{contract.title}-#{contract.comment} нет телефона</p>"
    else
      phone = "+380" + phone.value.gsub(/\W/,"").match(/[0-9]{9}$/).to_s
      if Gnokii.checkmobile(phone)
        Gnokii.send(sms, phone)
        message = "<p>#{sms} - #{contract.title}-#{contract.comment} отправленно на телефон #{phone}</p>"
        Sms.create!( :time => Time.now.strftime("%Y-%m-%d %H:%M"), :cid => contract.id, :smstype_id => type )
      else
        message = "<p>Сообщение не отправлено у абонента #{contract.title}-#{contract.comment} указан городской телефон #{phone}</p>"
      end
      return message
    end
  end

  def self.dayformat(day)
    f = %w[день дня дня дня дней]
    return f[day-1]
  end
end

class Gnokii
  def self.send(sms, phone)
    `echo "#{sms}" | /etc/sms_creator.sh -e "#{phone}"`
    #`echo "#{sms}" | gnokii --config /etc/gnokiirc --sendsms "#{phone}"`
    #STDOUT.print(x
  end
  def self.checkmobile(phone)
    array = %w[\+38050 \+38066 \+38095 \+38099 \+38067 \+38096 \+38097 \+38098 \+38063 \+38093 \+38068 \+38091 \+38092]
    mobilecheck = false
    array.each{|m| mobilecheck = true if phone =~ /^#{m}/}
    return mobilecheck
  end
end

Flag.where("pid=46").each do |f|
  if f.val == 1
    contract = f.contract
    b = contract.balances.where("yy=#{yy} and mm=#{mm}")[0]
    if b != nil && contract.status == 0
      balance = b.summa1 + b.summa2 - b.summa3 - b.summa4
      #Стоимость одного дня
      one_day = (b.summa3 / day)
      #Стоимость пяти дней
      five_days = 5 * one_day
      #Текст сообщения
      sms = ""
      #Если осталось на Х дней
      if balance < five_days && balance > 0
        #Осталось средств на Х дней
        days_left = balance / one_day
        dd = days_left.ceil
        dd = 1 if dd == 0
        s = contract.smses.where(["smstype_id=? and time>=?", 1, (timenow - 3.day).strftime("%Y-%m-%d %H:%M")])[0]
        if s.nil?
          sms = "На счете осталось на #{dd.to_s} #{Smssender.dayformat(dd)} работы в сети Интернет. Крыминфоком."
          text = text + Smssender.send(contract, sms, 1)
        end
      #Если баланс 0, но меньше лимити
      elsif balance < 0 && balance - one_day > contract.closesumma.to_f
        s = contract.smses.where(["smstype_id=? and time>=?", 2, (timenow - 5.day).strftime("%Y-%m-%d %H:%M")])[0]
        if s.nil?
          sms = "Аванс исчерпан, пополните счет в течение 5 дней. Крыминфоком."
          text = text + Smssender.send(contract, sms, 2)
        end
	#    Если баланс меньше лимита
	#    elsif balance + one_day < limit && contract.status == 3
	#      sms = "Услуга приостановлена, для активации пополните счет. Крыминфоком."
	#      s = contract.smses.where(["smstype_id=? and date<=", 3])[0]
	#      Smssender.send(contract,sms)
	#      Sms.create!(:date => Time.now.strftime("%Y-%m-%d %H:%M"),:cid => contract.id,:smstype_id => 3)
      end
    end
  end
end

#Отправка письма
if text != "<h3>Отправлены следующие СМС сообщения:</h3>"
  to="bgbilling@crimeainfo.com"
  from="ruby.ci.ukrpack.net@crimeainfo.com"
  subject="Отправлены следующие СМС #{timenow.strftime("%d.%m.%Y %H:%M")}"
  sendmail(text, to, from, subject)
end