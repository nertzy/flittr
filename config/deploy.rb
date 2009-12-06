set :application, 'flittr'
set :repository,  'git@nertzy.com:flittr.git'

set :scm, :git

set :deploy_to, '/var/www/flittr.nertzy.com'

server 'nertzy.com', :app, :web, :db, :primary => true

set :user, 'grant'

set :use_sudo, false

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do
  end
  task :stop do
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after 'deploy:update_code' do
  %w{database.yml}.each do |path|
    run "ln -nfs #{shared_path}/#{path} #{release_path}/config/#{path}"
  end
  %w{environment.rb gems specifications doc}.each do |path|
    run "ln -nfs #{shared_path}/bundler_gems/#{path} #{release_path}/vendor/bundler_gems/#{path}"
  end
  run "cd #{release_path}; /opt/ruby-enterprise/bin/gem bundle --only production --build-options #{shared_path}/build_options.yml"
  run "cd #{release_path}; RAILS_ENV=production /opt/ruby-enterprise/bin/gem exec rake db:migrate"
end
