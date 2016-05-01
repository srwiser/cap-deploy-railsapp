# config/unicorn.rb
worker_processes 2

# We deploy with capistrano, so "current" links to root dir of current release
app_path = File.expand_path(File.dirname(__FILE__) + '/..')
working_directory app_path

# Listen on unix socket
listen app_path + '/tmp/unicorn.sock', :backlog => 64

timeout 300

pid app_path + '/tmp/pids/unicorn.pid'

stderr_path app_path + '/log/unicorn.log'
stdout_path app_path + '/log/unicorn.log'

# Load the app up before forking.
preload_app true

GC.respond_to?(:copy_on_write_friendly=) &&
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end