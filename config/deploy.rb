set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")
require "rvm/capistrano"  
require "bundler/capistrano"
require "delayed/recipes"  
require "whenever/capistrano"
load "deploy/assets"
set :rvm_type, :system
set :rvm_path, "/usr/local/rvm"

default_run_options[:pty] = true
set :application, "webmon"
set :repository,  "git@github.com:Supro/bgwebmon.git"

set :scm, :git

set :port, 22
set :user, "deploy"
set :use_sudo, false

set :ssh_options, {
	user: 'deploy',
	keys: %w(/home/deploy/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey)
}

set :branch, "master"
set :deploy_via, :remote_cache
set :keep_releases, 3
set :deploy_to, "/var/www/apps/#{application}"
set :rails_env, "production"
set :domain, "194.54.152.50"
set :scm_command, "/usr/bin/git"
set :scm_verbose, true
set :normalize_asset_timestamps, false
set :whenever_identifier, "reminder"
set :whenever_command, "bundle exec whenever"

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

role :web, domain                         
role :app, domain                         
role :db,  domain, primary: true

ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{latest_release} && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end

  task :start do
    run "cd #{latest_release} && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end

  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
  
  # task :graphs do
  # 	run "ln -s /var/www/graphs /var/www/webmon/current/graphs && mkdir #{current_path}/public/graphs && chown nobody #{current_path}/public/graphs" 
  # end
  task :db do
  	run "ln -s /var/www/bgwebmon/application.yml #{current_release}/config/application.yml && ln -s /var/www/bgwebmon/database.yml #{current_release}/config/database.yml && ln -s /var/www/bgwebmon/secret_token.rb #{current_release}/config/initializers/secret_token.rb"
  end
  # task :files do
  #   run "ln -s /var/www/wemonfiles/files #{current_path}/public/ && chown nobody #{current_path}/public/files"
  # end
  task :delayed_indexes do 
    run "cd #{current_path} && script/rails runner 'Delayed::Backend::Mongoid::Job.create_indexes'"
  end
end

before "deploy:assets:precompile", "deploy:db"
after "deploy", "deploy:cleanup", "whenever_command", "deploy:restart", "delayed_job:restart", "deploy:delayed_indexes"