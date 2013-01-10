DEFAULT_PORT = 4567

namespace :development do
  desc "Start the server in development mode."
  task :server, :port do |t, args|
    port = args[:port] || DEFAULT_PORT
    ENV["RACK_ENV"] = "development"
    puts "Starting the server in DEVELOPMENT mode..."
    sh "rackup -p #{port}"
  end
end

namespace :production do
  desc "Start the server in production mode."
  task :server, :port do |t, args|
    port = args[:port] || DEFAULT_PORT
    ENV["RACK_ENV"] = "production"
    puts "Starting the server in PRODUCTION mode..."
    sh "rackup -p #{port}"
  end
end

desc "Install the required gems."
task :install do
  sh "bundle install"
end

desc "Alias for development:server task."
task :server, [ :port ] => [ "development:server" ]

task :default, [ :port ] => [ "install", "server" ]
