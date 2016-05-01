set :stage, :local

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :app, []
role :db, []
set :deployuser, ask('Deploy User?', nil)
set :password, ask('Deploy user Password?', nil)
# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server '192.168.5.10', user: "#{fetch(:deployuser)}", password: "#{fetch(:password)}", roles: [:app, :db], port:22

set :source_profile, "source /home/#{fetch(:deployuser)}/.bash_profile"
set :deploy_to, "/var/www/#{fetch(:application)}"
set :dir, "#{fetch(:deploy_to)}/current"
set :branch, 'develop'
set :username, ask('Git Username', nil)
set :password, ask('Git Password', nil)
set :repo_url, "https://"+ fetch(:username) +":" + fetch(:password)+ "@github.com/"+ fetch(:username) +"/#{fetch(:application)}.git"
set :repo_path, "#{fetch(:deploy_to)}"