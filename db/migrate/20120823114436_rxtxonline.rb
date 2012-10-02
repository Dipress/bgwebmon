# coding: utf-8
#class Rxtxonline < ActiveRecord::Migration
#  def self.up
#    add_column "user_login_#{Bgmodule.find_by_name("dialup").id}", :online, :boolean, :default => 0 if !Rails.env.test? 
#    add_column "user_login_#{Bgmodule.find_by_name("dialup").id}", :rx, :bigint, :default => 0 if !Rails.env.test? 
#    add_column "user_login_#{Bgmodule.find_by_name("dialup").id}", :tx, :bigint, :default => 0 if !Rails.env.test? 
#    add_column "#{ActiveRecord::Base.connection.execute("show tables like 'user_login_%';").first[0]}", :online, :boolean, :default => 0 if Rails.env.test? 
#    add_column "#{ActiveRecord::Base.connection.execute("show tables like 'user_login_%';").first[0]}", :rx, :bigint, :default => 0 if Rails.env.test? 
#    add_column "#{ActiveRecord::Base.connection.execute("show tables like 'user_login_%';").first[0]}", :tx, :bigint, :default => 0 if Rails.env.test? 
#  end

#  def self.down
#    remove_column "user_login_#{Bgmodule.find_by_name("dialup").id}", :online if !Rails.env.test? 
#    remove_column "user_login_#{Bgmodule.find_by_name("dialup").id}", :rx if !Rails.env.test? 
#    remove_column "user_login_#{Bgmodule.find_by_name("dialup").id}", :tx if !Rails.env.test?
#    remove_column "#{ActiveRecord::Base.connection.execute("show tables like 'user_login_%';").first[0]}", :online if Rails.env.test? 
#    remove_column "#{ActiveRecord::Base.connection.execute("show tables like 'user_login_%';").first[0]}", :rx if Rails.env.test? 
#    remove_column "#{ActiveRecord::Base.connection.execute("show tables like 'user_login_%';").first[0]}", :tx if Rails.env.test? 
#  end
#end
