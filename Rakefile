require "bridgetown"

Bridgetown.load_tasks

task default: :server

desc "Start the local server"
task :server do
  ENV["BRIDGETOWN_ENV"] = "development"
  Bridgetown::Commands::Start.start
end

desc "Build the Bridgetown site for deployment"
task :build => "frontend:build" do
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

desc 'Deploy to GitHub Pages'
task :deploy => ["deploy:push_master", :build, "deploy:push_gh_pages"] do

end

namespace :deploy do
  task :push_master do
    puts 'Push to `master`'
    system 'git push origin master'
  end

  task :push_gh_pages do
    puts 'Push to `gh_pages`'
    cd 'output' do
      system 'git add -A'
      system "git commit -m 'update at #{Time.now.utc}'"
      system 'git push origin gh-pages'
    end
  end
end
