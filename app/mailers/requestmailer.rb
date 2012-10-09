# coding: utf-8
class Requestmailer < ActionMailer::Base
  def requestfl_added(requestfl,to_email)
  	@urlfor = "http://ruby.ci.ukrpack.net/requestfl/#{requestfl.id}"
    mail(:from => "ruby.ci.ukrpack.net@crimeainfo.com", :to => to_email, :subject => "Добавлена заявка на заведение абонента в биллинг - #{requestfl.fio}")
  end 
  def requestfl_ready(requestfl,to_email)
    @urlfor = "http://ruby.ci.ukrpack.net/requestfl/#{requestfl.id}"
    mail(:from => "ruby.ci.ukrpack.net@crimeainfo.com", :to => to_email, :subject => "Заявка на заведение абонента #{requestfl.fio}")
  end 
  def requestfl_connected(requestfl,to_email)
    @urlfor = "http://ruby.ci.ukrpack.net/requestfl/#{requestfl.id}"
    mail(:from => "ruby.ci.ukrpack.net@crimeainfo.com", :to => to_email, :subject => "Заявка на заведение абонента #{requestfl.fio}")
  end 
  def requestfl_finish(requestfl,to_email)
    @urlfor = "http://ruby.ci.ukrpack.net/requestfl/#{requestfl.id}"
    mail(:from => "ruby.ci.ukrpack.net@crimeainfo.com", :to => to_email, :subject => "Заявка на заведение абонента #{requestfl.fio}")
  end 
end
