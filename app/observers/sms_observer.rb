require 'nokogiri'
require 'open-uri'
require 'net/http'
class SmsObserver < ActiveRecord::Observer
  observe :sms

  def after_create record
    record.status = Ip2sms.new(record.phone, record.text).delay.send
  end
end