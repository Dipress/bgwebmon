require 'nokogiri'
require 'open-uri'
require 'net/http'
class SmsObserver < ActiveRecord::Observer
  observe :sms

  def after_create record
    record.status = Vostok::Sms.new(record.phone, record.text).send
  end
end