# coding: utf-8
class Requestmailer < ActionMailer::Base
  def requestfl_added(requestfl,to_email)
    @urlfor = "http://crimeainfo.com/requestfl/#{requestfl.id}"
    @request = requestfl
    mail(:from => "ruby@crimeainfo.com", :to => to_email, :subject => "Добавлена заявка на заведение абонента в биллинг - #{requestfl.fio}")
  end 
  def requestfl_edited(requestfl,to_email)
    @urlfor = "http://ruby.crimeainfo.com/requestfl/#{requestfl.id}"
    @request = requestfl
    mail(:from => "ruby@crimeainfo.com", :to => to_email, :subject => "Добавлена заявка на заведение абонента в биллинг - #{requestfl.fio}")
  end 
  def requestfl_ready(requestfl,to_email,user)
    @user = user
    @urlfor = "http://ruby.crimeainfo.com/requestfl/#{requestfl.id}"
    mail(:from => "ruby@crimeainfo.com", :to => to_email, :subject => "Заявка на заведение абонента #{requestfl.fio}")
  end 
  def requestfl_connected(requestfl,to_email,user)
    @user = user
    @urlfor = "http://ruby.crimeainfo.com/requestfl/#{requestfl.id}"
    mail(:from => "ruby@crimeainfo.com", :to => to_email, :subject => "Заявка на заведение абонента #{requestfl.fio}")
  end 
  def requestfl_finish(requestfl,to_email,user)
    @user = user
    @urlfor = "http://ruby.crimeainfo.com/requestfl/#{requestfl.id}"
    mail(:from => "ruby@crimeainfo.com", :to => to_email, :subject => "Заявка на заведение абонента #{requestfl.fio}")
  end 

  def requestfl_discard(requestfl,to_email,user)
    @why = requestfl.discard
    @user = user
    @urlfor = "http://ruby.crimeainfo.com/requestfl/#{requestfl.id}"
    mail(:from => "ruby@crimeainfo.com", :to => to_email, :subject => "Заявка на заведение абонента #{requestfl.fio} отклонена")
  end 

  def task_created(task,user,to_email)
    @user = user
    @urlfor = "http://ruby.crimeainfo.com/tasks/#{task.id}"
    mail(:from => "ruby@crimeainfo.com", :to => to_email, :subject => "Новая задача: #{task.title}")
  end 

  def task_comment(task,user,to_email)
    @user = user
    @urlfor = "http://ruby.crimeainfo.com/tasks/#{task.id}"
    mail(:from => "ruby@crimeainfo.com", :to => to_email, :subject => "Новый комментарий к заявке: #{task.title}")
  end

  def task_taken(task,user,to_email)
    @user = user
    @urlfor = "http://ruby.crimeainfo.com/tasks/#{task.id}"
    mail(:from => "ruby@crimeainfo.com", :to => to_email, :subject => "Заявку приняли:  #{task.title}")
  end

  def task_end(task,user,to_email)
    @user = user
    @urlfor = "http://ruby.crimeainfo.com/tasks/#{task.id}"
    mail(:from => "ruby@crimeainfo.com", :to => to_email, :subject => "Заявка выполнена: #{task.title}")
  end

  def task_restored(task,user,to_email)
    @user = user
    @urlfor = "http://ruby.crimeainfo.com/tasks/#{task.id}"
    mail(:from => "ruby@crimeainfo.com", :to => to_email, :subject => "Заявка восстановлена: #{task.title}")
  end

end
