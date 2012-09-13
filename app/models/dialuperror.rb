# coding: utf-8
class Dialuperror < ActiveRecord::Base

# !Внимание можно заменить строки
 self.table_name = "log_error_#{Bgmodule.find_by_name("dialup").id}_#{Time.now.strftime('%Y%m')}" if !Rails.env.test?
 self.table_name = "#{ActiveRecord::Base.connection.execute("show tables like 'log_error_%%_#{Time.now.strftime('%Y%m')};").first[0]}"  if Rails.env.test?
# на
# self.table_name = "user_alias_6" , где 6 - id модуля dialup в таблице module
# это в среднем ускорит процесс на 0.3ms в production/development и на 4.4ms в test

  # Данная строка устанавливает название таблицы для production/deveopment
  #self.table_name = "log_error_6_#{Time.now.strftime('%Y%m')}"
  # Данная строка устанавливает название таблицы для test,
  # т.к база данных для тестов пустая и имеет только структуру
  #self.table_name = "#{ActiveRecord::Base.connection.execute("show tables like \"log_error_%%_#{Time.now.strftime('%Y%m')}\";").first[0]}" if Rails.env.test?
  self.primary_key = "log_rec_id"

  belongs_to :dialuplogin, :class_name => 'Dialuplogin', :foreign_key => 'lid'
  has_one :dialupalias, :through => :dialuplogin

  belongs_to :contract, :class_name => 'Contract', :foreign_key => 'cid'
end
