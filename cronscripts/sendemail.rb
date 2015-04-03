#!/usr/bin/env ruby
# coding: utf-8
require 'rubygems'
require 'tlsmail'
require 'net/smtp'

def sendmail(text, to, from, subject)
message = <<MESSAGE_END
From: Биллинговая система <#{from}>
To: Сотрудникам ООО 'Крыминфоком' <#{to}>
MIME-Version: 3.3.1
Content-type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: #{subject}
Date: #{Time.now.strftime("%a, %d %b %Y %H:%M:%S %z")}

#{text}

MESSAGE_END
	

	#Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
	Net::SMTP.start('mail.crimeainfo.com', 25, 'ruby.crimeainfo.com') do |s|
  		s.send_message message, from, to
	end
	
end