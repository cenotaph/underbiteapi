# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "underbiteapi"
set :repo_url, "git@github.com:cenotaph/underbiteapi.git"
set :branch, ENV['BRANCH'] if ENV['BRANCH']
set :rvm_ruby_version, '2.7.1'
set :keep_releases, 2
set :linked_files, %w{config/database.yml  config/master.key  config/puma.rb }
set :linked_dirs, %w{ log shared tmp}
set :deploy_to, "/var/www/underbite/api"
set :assets_roles, [:web, :app]
set :delayed_job_workers, 1