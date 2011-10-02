# -*- coding: utf-8 -*-

set :application, "contests"
role :app, "69.164.213.254"
role :web, "69.164.213.254"
role :db, "69.164.213.254", :primary => true

set :user, "rails"
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :keep_releases, 30


set :scm, "git"
set :repository, "git@github.com:andmej/andr.esmejia.git"
set :branch, "rails3"

require 'bundler/capistrano'

# RVM stuff
set :rvm_ruby_string, '1.9.2-p290'
set :rvm_type, :user
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                               # Load RVM's capistrano plugin.


#########################################################

namespace :deploy do
  desc "Tell Passenger to restart."
  task :restart, :roles => :web do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Do nothing on startup so we don't get a script/spin error."
  task :start do
    puts "You may need to restart Nginx."
  end

  desc "Symlink extra configs and folders."
  task :symlink_extras do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

namespace :db do
  desc "Migrates the production database."
  task :migrate do
    run "cd #{current_path} && rake RAILS_ENV=production db:migrate"
  end
end

after "deploy:update_code", "deploy:symlink_extras"