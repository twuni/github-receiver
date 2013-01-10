namespace :development do
  desc "Start the server in development mode."
  task :server do
    ENV["RACK_ENV"] = "development"
    sh "rackup -p 4567"
  end
end

namespace :production do
  desc "Start the server in production mode."
  task :server do
    ENV["RACK_ENV"] = "production"
    sh "rackup -p 4567"
  end
end

desc "Install the required gems."
task :install do
  sh "bundle install"
end

desc "Start the server on port 4567."
task :server => [ "development:server" ]

task :default => [ "install", "server" ]
