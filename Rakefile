#!/user/bin/env ruby

ENV["RACK_ENV"] ||= "development"

require "rubygems"
require "bundler"

Bundler.setup
Bundler.require( :default, ENV["RACK_ENV"].to_sym )

require "rake"

namespace :setup do

  desc "Install the dependencies for a development environment."
  task :development do
    sh "bundle install --without production"
  end

  desc "Install the dependencies for a production environment."
  task :production do
    sh "bundle install"
    sh "bundle install --deployment"
  end

end

desc "Start the server on port 4567."
task :server do
  sh "rackup -p 4567"
end

task :default => [ "setup:development", "server" ]
