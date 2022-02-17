require "bridgetown"

Bridgetown.load_tasks

task default: :server

desc "Start the local server"
task :server do
  ENV["BRIDGETOWN_ENV"] = "development"
  Bridgetown::Commands::Start.start
end

desc "Build the Bridgetown site for deployment"
task :build => [:clean, "frontend:build"] do
  ENV["BRIDGETOWN_ENV"] = "production"
  Bridgetown::Commands::Build.start
end

desc "Build the site in a test environment"
task :test do
  ENV["BRIDGETOWN_ENV"] = "test"
  Bridgetown::Commands::Build.start
end

desc "Runs the clean command"
task :clean do
  Bridgetown::Commands::Clean.start
end

namespace :frontend do
  desc "Build the frontend with esbuild for deployment"
  task :build do
    sh "yarn run esbuild"
  end

  desc "Watch the frontend with esbuild during development"
  task :dev do
    sh "yarn run esbuild-dev"
  rescue Interrupt
  end
end

#
# Add your own Rake tasks here! You can use `environment` as a prerequisite
# in order to write automations or other commands requiring a loaded site.
#
# task :my_task => :environment do
#   puts site.root_dir
#   automation do
#     say_status :rake, "I'm a Rake tast =) #{site.config.url}"
#   end
# end
