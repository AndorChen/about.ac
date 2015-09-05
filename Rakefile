desc 'Deploy to FTP'
task :deploy do
  system 'bundle exec glynn'
end

desc "Launch preview environment"
task :preview do
  system "bundle exec jekyll s --baseurl='/aboutac' --host='0.0.0.0'"
end

task :s => :preview
task :server => :preview
task :default => :preview
