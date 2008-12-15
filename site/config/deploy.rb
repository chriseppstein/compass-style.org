set :user, 'compassweb'
set :domain, 'compass-style.org'
set :project, 'compass'
set :application, "compass"
set :applicationdir, "/home/#{user}/#{application}"
set :scm, :git
set :repository,  "git://76.102.102.216/compass-style.org/.git"

task :move_directory, :roles => [:app] do
  run "cp -Rf #{release_path}/site/* #{release_path}/"
end

task :create_required_directories, :rolls => [:app] do
  run "mkdir -p #{release_path}/public/stylesheets"
end

before 'deploy:finalize_update', :move_directory
before 'deploy:finalize_update', :create_required_directories

desc "After updating code we need to populate a new database.yml"
task :after_update_code, :roles => :app do
  require "yaml"
  set :production_database_password, proc { Capistrano::CLI.password_prompt("Production database remote Password : ") }

  buffer = YAML::load_file('config/database.yml')
  # get ride of uneeded configurations
  buffer.delete('test')
  buffer.delete('development')
  
  # Populate production element
  buffer['production']['password'] = production_database_password
  
  put YAML::dump(buffer), "#{release_path}/config/database.yml", :mode => 0664
end

role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :deploy_to, applicationdir
set :deploy_via, :export

set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

deploy.task :start do
  run "touch #{release_path}/tmp/restart.txt"
end
