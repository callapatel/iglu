require 'dotenv'
Dotenv.load

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'iglu'
set :repo_url, 'git@github.com:callapatel/iglu.git'
set :use_sudo, false

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
 set :deploy_to, '/var/www/iglu'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
 set :default_env, {'YELP_CONSUMER_KEY' => ENV['YELP_CONSUMER_KEY'], 'YELP_CONSUMER_SECRET' => ENV['YELP_CONSUMER_SECRET'],
   'YELP_TOKEN' => ENV['YELP_TOKEN'], 'YELP_TOKEN_SECRET' => ENV['YELP_TOKEN_SECRET']}

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
