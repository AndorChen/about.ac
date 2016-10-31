desc 'Deploy to bitbucket and aerobatic'
task :deploy do
  puts 'Push to `master`'
  system "git push origin master"
  puts
  puts 'Push to `gh-pages`'
  system "bundle exec jekyll build"
  puts
  cd '_site' do
    system "git add -A"
    system "git commit -m 'update at #{Time.now.utc}'"
    puts
    system "git push origin gh-pages"
  end
end

desc "Launch preview environment"
task :preview do
  system "bundle exec jekyll s --drafts --baseurl='/aboutac' --host='0.0.0.0'"
end

desc 'Alias to :deploy'
task :d => :deploy
task :push => :deploy

desc 'Alias to :preview'
task :s => :preview

desc 'Alias to :preview'
task :server => :preview

desc 'Alias to :preview'
task :default => :preview
