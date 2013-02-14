#!/usr/bin/env ruby
# coding: utf-8
require "#{File.dirname(__FILE__)}/database.rb"
require "#{File.dirname(__FILE__)}/sendemail.rb"


timenow = Time.now 

text = "<h3>Отправлены следующие СМС сообщения:</h3>"

Payment.where(["dt>=?", (timenow - 1.day).strftime("%Y-%m-%d %H:%M")]).each do |p|
  Sms.create!(:date => Time.now.strftime("%Y-%m-%d %H:%M"),
              :cid => p.cid,
              :smstype_id => 5)
  sms = "Крыминфоком, поступил платеж на сумму #{sprintf('%.02f',p.summa)} грн."
  contract = p.contract
  phone = contract.phones.where(["pid=?", 9])[0]
  if phone.nil?
     message = "<p>Сообщение не отправлено у абонента #{contract.title} нет телефона по фин. вопросам</p>"
     text = text + message
  else
    array = %w[\+38050 \+38066 \+38095 \+38099 \+38067 \+38096 \+38097 \+38098 \+38063 \+38093 \+38068 \+38091 \+38092]
    mobilecheck = false
    phone = phone.value.gsub(/;(.+)$/, "").gsub(/ /, "").gsub(/^0/, "+38")
    array.each{|m| 
      mobilecheck = true if phone =~ /^#{m}/}
    if mobilecheck
      #Gnokii.send(sms, phone)
      message = "<p>#{sms} - #{contract.title} - отправленно на телефон #{phone}</p>"
    else
      message = "<p>Сообщение не отправлено у абонента #{contract.title} указан городской телефон #{phone}</p>"
    end
    text = text + message
  end
end

class Gnokii
  def self.send(sms, phone)
    x = `echo "#{sms}" | gnokii --config /etc/gnokiirc --sendsms "#{phone}"`
    STDOUT.print(x)
  end
end

#Отправка письма
if text != "<h3>Отправлены следующие СМС сообщения:</h3>"
  to="bgbilling@crimeainfo.com"
  from="ruby.ci.ukrpack.net@crimeainfo.com"
  subject="Отправлены следующие СМС #{timenow.strftime("%d.%m.%Y %H:%M")}"
  sendmail(text, to, from, subject)
end