require "json"
require "sinatra/base"
require "yaml"

class GitHubReceiver < Sinatra::Base

  # Load the configuration file appropriate to our environment.
  CONFIG = YAML.load_file("config/development.yml") if development?
  CONFIG = YAML.load_file("config/production.yml") if production?

  # Create some convenient aliases.
  clone_dir = CONFIG["clone_to"]
  origin_url = CONFIG["origin"]["url"]
  allowed_ips = CONFIG["origin"]["allowed_ips"] || []
  allowed_owners = CONFIG["origin"]["allowed_owners"] || []

  post "/" do

    # 1. Validate the client IP address against our white list.
    return 403 unless allowed_ips.empty? || allowed_ips.include?(request.ip)

    # 2. Parse the JSON payload we're expecting from GitHub.
    payload = JSON.parse(params[:payload])

    # 3. Alias the parts of the payload we care about to make them easier to work with.
    begin
      ref = payload["ref"]
      project = payload["repository"]["name"]
      owner = payload["repository"]["owner"]["name"]
    rescue Exception => exception
      # Problem? We'll handle this in just a moment.
    end

    # 4. Validate that we have all required information.
    return 400 unless ref && project && owner

    # 5. Validate the repository's owner against our white list.
    return 401 unless allowed_owners.empty? || allowed_owners.include?(owner)

    owner_dir = "#{clone_dir}/#{owner}"
    project_dir = "#{owner_dir}/#{project}"

    if File.directory?(project_dir)
      # 6. If the project directory exists, assume we have already cloned it and we just need to pull.
      return 400 unless system("( cd #{project_dir} && exec git pull origin #{ref} )")
    else
      # 6. If the project directory does not exist, then create the necessary paths and clone it.
      Dir.mkdir(clone_dir) unless File.directory?(clone_dir)
      Dir.mkdir(owner_dir) unless File.directory?(owner_dir)
      return 404 unless system("git clone #{origin_url}#{owner}/#{project}.git #{project_dir}")
    end

    # Success!
    return 200

  end

end
