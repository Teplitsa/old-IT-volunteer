require './config/boot'
#require 'airbrake/capistrano'
require "rvm/capistrano"
require "bundler/capistrano"
require 'capistrano/ext/multistage'
require 'thinking_sphinx/deploy/capistrano'
require "whenever/capistrano"

set :application, "volunteer"

set :deploy_to, "/server/www/#{application}/main/deploy"

set :scm, :git
set :repository, "git@github.com:progress-engine/volunteer.git"
set :deploy_via, :remote_cache

set :stages, %w(staging production) 
set :default_stage, "staging"


set :user, "www-data"
set :use_sudo, false
set :ssh_options, forward_agent: true

set :rvm_ruby_string, "1.9.3@volunteer"
set :rvm_type, :system

set :normalize_asset_timestamps, false # http://stackoverflow.com/questions/8436480/no-such-file-or-directory-in-capistrano-deploy

depend :remote, :gem, "bundler", ">=1.0.21"

set :symlinks, %w(config/database.yml config/settings.local.yml)
set :unicorn_conf, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"

set :shared_assets, %w{ public/uploads }

set :whenever_command, "bundle exec whenever"
set :whenever_environment, defer { stage }

before "deploy:setup",    "assets:symlinks:setup"
before "deploy:make_symlinks",  "assets:symlinks:update"

after "deploy", "deploy:migrate"
after "deploy", "deploy:cleanup" # keeps only last 5 releases
after "deploy:finalize_update", "deploy:make_symlinks"

# for thinking_sphinx
before 'deploy:update_code', 'thinking_sphinx:stop'
after 'deploy:update_code', 'thinking_sphinx:start'
after 'deploy:finalize_update', 'sphinx:symlink_indexes'

namespace :deploy do

  desc "Creates initial templates for server-side configs."
  task :setup_configs do
    run "mkdir -p #{shared_path}/config"
    put File.read("config/examples/database.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/examples/settings.local.yml"), "#{shared_path}/config/settings.local.yml"
    puts "---------------------------------------------------"
    puts "Now edit the config files in #{shared_path}/config."
  end

  desc "Creates additional symlinks for the shared configs."
  task :make_symlinks, :roles => :app, :except => { :no_release => true } do
    commands = fetch(:symlinks, []).map do |path|
      "rm -rf #{release_path}/#{path} && ln -nfs #{shared_path}/#{path} #{release_path}/#{path}"
    end

    run "cd #{release_path} && #{commands.join(" && ")}"
  end

  ### Unicorn management
  desc "Restarts Unicorn server with zero-downtime. If Unicorn server is running, sends USR2 signal to the master process, otherwise starts up the server as usual."
  task :restart, :roles => :app do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{current_path} && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end

  desc "Starts up the Unicorn server."
  task :start, :roles => :app do
    run "cd #{current_path} && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end

  desc "Stops the Unicorn server. Preforms graceful shutdown using QUIT signal."
  task :stop, :roles => :app do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end


end

namespace :admin do
  desc "Tail production log files."
  task :tail_logs, :roles => :app do
    invoke_command "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
      puts "\n#{channel[:host]}: #{data}" if stream == :out
      warn "[err :: #{channel[:server]}] #{data}" if stream == :err
    end
  end


  # Add this to your capfile if you're getting burned on first deploy to a new host
  # If you're getting 'Host key verification failed.' errors on your initial
  # checkout of a repo using capistrano, this will fix it up
  desc "fix for 'Host key verification failed.'"
  task :a_friend_of_mine_is_a_friend_of_yours do
    # transfer what *I* know about github to the host
    github_known_hosts_line = `cat ~/.ssh/known_hosts | grep github.com`
    run "echo #{github_known_hosts_line} >> ~/.ssh/known_hosts"
  end
end


namespace :assets  do
  namespace :symlinks do
    desc "Setup application symlinks for shared assets"
    task :setup, :roles => [:app, :web] do
      shared_assets.each { |link| run "mkdir -p #{shared_path}/#{link}" }
    end

    desc "Link assets for current deploy to the shared location"
    task :update, :roles => [:app, :web] do
      shared_assets.each { |link| run "ln -nfs #{shared_path}/#{link} #{release_path}/#{link}" }
    end
  end
end



namespace :sphinx do
  desc "Symlink Sphinx indexes"
  task :symlink_indexes, :roles => [:app] do
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end
end



