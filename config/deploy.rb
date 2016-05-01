# config valid only for Capistrano 3.2.x
lock '3.2.1'

set :application, 'sampleapp'
set :ruby_version, '2.2.1'
set :default_stage, 'local'

set :rails_env, 'production'

# Default value for :log_level is :debug
set :log_level, :debug

set :pty, true
# Default value for :linked_files is []
#set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

set :reply, ask('Have you changed Config files in shared folder (yes/no)?', nil)
	if fetch(:reply).upcase == 'YES' 
		before :starting, 'env:prepare_env'

		before :started, 'app:app_stop'

		desc 'Restart application'
		task :restart do
			puts 'Restarting Application server'
			invoke 'app:app_restart'
		end

		before :finishing, 'app:app_restart'

		begin
			before :finishing, 'deploy:cleanup'
		rescue
			info 'Deploy Successful'
		end

		task :failed do
			puts 'deployment failed'
		end

	else
		abort('Please change configuration files to deploy!!')
	end

end