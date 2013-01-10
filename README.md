# GitHub Web Hook

This is a simple web hook that keeps a local repository synchronized with GitHub.

## Running

 1. Clone this project.
 2. Edit **config/production.yml** and/or **config/development.yml** to taste.
 3. Run `rake`.

Running `rake` with no arguments will install gem dependencies via Bundler and
launch a server running in **development** mode on port **4567**. For more
information about the rake options, inspect the **Rakefile** or run `rake -D`.
