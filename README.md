Instructions for Deploying on Production

1) To setup Postgres database, create database.yml from database.yml.sample in shared folder

2) First time, run `bundle install` in this folder

3) Create production.rb from production.rb.sample in config/deploy/ folder

4) Change configuration files in shared folder according to your need.

4) Run `cap production db:setup --trace` to deploy database

5) Run `cap production deploy --trace` to deploy app
