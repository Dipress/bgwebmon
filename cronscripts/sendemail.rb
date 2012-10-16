#!/usr/bin/env ruby
# coding: utf-8
require 'rubygems'
require 'tlsmail'
require 'net/smtp'

def sendmail(text, to, from, subject)
message = <<MESSAGE_END
From: Биллинговая система <#{from}>
To: Сотрудникам ООО 'Крыминфоком' <#{to}>
MIME-Version: 1.0
Content-type: text/html
Subject: #{subject}

#{text}

MESSAGE_END
	

	#Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
	Net::SMTP.start('mail.crimeainfo.com', 25, 'ruby.ci.ukrpack.net') do |s|
  		s.send_message message, from, to
	end
	
end