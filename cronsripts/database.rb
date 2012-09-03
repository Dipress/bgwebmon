#!/usr/bin/env ruby
# coding: utf-8
require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "bill",
  :password => "bgbilling",
  :database => "bgbilling"
)

class Bgmodule < ActiveRecord::Base
  self.table_name = "module"
  self.primary_key = "id"
end

class Dialupalias < ActiveRecord::Base
  self.table_name = "user_alias_#{Bgmodule.find_by_name("dialup").id}"
  self.primary_key = "id"  
  belongs_to :dialuplogin, :class_name => 'Dialuplogin', :foreign_key => 'login_id'
end

class Dialuplogin < ActiveRecord::Base
  self.table_name = "user_login_#{Bgmodule.find_by_name("dialup").id}"
  self.primary_key  = "id"
  has_one :dialupalias, :class_name => 'Dialupalias', :foreign_key => 'login_id'
  attr_accessible :rx, :tx, :online
  validates :rx, :presence => true, :numericality => { :only_integer => true }
  validates :tx, :presence => true, :numericality => { :only_integer => true }
  validates :online, :inclusion => {:in => [true, false]}
end