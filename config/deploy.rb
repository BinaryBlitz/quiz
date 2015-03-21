require 'rvm/capistrano'
require 'bundler/capistrano'
load 'deploy/assets'

set :application, "quizapp"
set :rails_env, "production"
set :domain, "quizapp@binaryblitz.ru"
set :deploy_to, "/home/quizapp/#{application}"
set :use_sudo, false
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
set :normalize_asset_timestamps, false
set :rvm_ruby_string, 'ruby-2.2.0@quizapp'

set :scm, :git
set :repository, "git@github.com:BinaryBlitz/quiz_app.git"
set :branch, "pictures"
set :deploy_via, :remote_cache

role :web, domain
role :app, domain
role :db,  domain, :primary => true

before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby'


after 'deploy:update_code', :roles => :app do
  run "rm -f #{current_release}/config/secrets.yml"
  run "ln -nfs #{deploy_to}/shared/config/secrets.yml #{current_release}/config/secrets.yml"
  # run "rm -f #{current_release}/public/uploads"
  # run "ln -nfs #{deploy_to}/shared/public/uploads #{current_release}/public/uploads"
  # run "cd #{current_release}; rake db:schema:load RAILS_ENV=#{rails_env}"
  run "cd #{current_release}; bundle exec rake db:migrate RAILS_ENV=#{rails_env}"
  # run "rm -f #{current_release}/config/initializers/app_constants.rb"
  # run "ln -nfs #{deploy_to}/shared/config/initializers/app_constants.rb #{current_release}/config/initializers/app_constants.rb"
  # run "ln -nfs #{deploy_to}/shared/secret_token.rb #{current_release}/config/initializers/secret_token.rb"
end

before "deploy:assets:precompile", "deploy:link_db"


set :keep_releases, 3
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :link_db do
    run "rm -f #{current_release}/config/database.yml"
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
  end

  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "cd #{current_path}; bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end
