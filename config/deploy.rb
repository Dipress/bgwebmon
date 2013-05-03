set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")
require "rvm/capistrano"  
require "bundler/capistrano"
require "delayed/recipes"  
load "deploy/assets"
set :rvm_type, :user

default_run_options[:pty] = true
set :application, "webmon"
set :repository,  "git@github.com:Supro/bgwebmon.git"

set :scm, :git

set :user, "root"
set :use_sudo, false

set :branch, "master"
set :deploy_via, :remote_cache
set :keep_releases, 3
set :deploy_to, "/var/www/#{application}"
set :rails_env, "production"
set :domain, "194.54.152.23"
set :scm_command, "/usr/bin/git"
set :scm_verbose, true
set :normalize_asset_timestamps, false

role :web, domain                         
role :app, domain                         
role :db,  domain, :primary => true

ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

namespace :deploy do
  desc "cause Passenger to initiate a restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end
  task :graphs do
  	run "ln -s /var/www/graphs /var/www/webmon/current/graphs && mkdir #{current_path}/public/graphs && chown nobody #{current_path}/public/graphs" 
  end
  task :db do
  	run "ln -s /var/www/bgwebmon/database.yml #{current_path}/config/database.yml && ln -s /var/www/bgwebmon/secret_token.rb #{current_path}/config/initializers/secret_token.rb"
  end
  task :files do
    run "ln -s /var/www/wemonfiles/files #{current_path}/public/ && chown nobody #{current_path}/public/files"
  end
end

after "deploy", "deploy:cleanup", "delayed_job:restart", "deploy:db", "deploy:files", "deploy:graphs", "deploy:restart"