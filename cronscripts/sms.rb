#!/usr/bin/env ruby
# coding: utf-8
require "#{File.dirname(__FILE__)}/database.rb"
require "#{File.dirname(__FILE__)}/sendemail.rb"


timenow=Time.now 
text="<h3>Отправлены следующие СМС сообщения:</h3>"

def day_format(d)
  f=%w[день дня дня дня дней]
  return f[d-1]
end

#Отправка письма
to="d3.supro@gmail.com"
from="ruby.ci.ukrpack.net@crimeainfo.com"
subject="Отправлены следующие СМС"
sendmail(text, to, from, subject)