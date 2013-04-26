# coding: utf-8
class Paymentmailer < ActionMailer::Base

  def payment_added payment, to_email
    @urlfor = "http://ruby.ci.ukrpack.net/requestfl/#{payment.id}"
    mail(from: "ruby.ci.ukrpack.net@crimeainfo.com", to: to_email, subject: "Платежный представитель добавил платеж")
  end 

  def payment_processed payment, to_email
    @urlfor = "http://ruby.ci.ukrpack.net/requestfl/#{payment.id}"
    mail(from: "ruby.ci.ukrpack.net@crimeainfo.com", to: to_email, subject: "Платеж обработан")
  end 
end