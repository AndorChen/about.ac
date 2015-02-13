desc "Push to github"
task :push do
  puts   "Pushing to `source' branch:"
  system "git push origin source"
  puts   "`source' branch updated."
  puts

  puts   "Building site...."
  system "bundle exec jekyll build"
  puts   "Site updated."
  puts

  cd '_site' do
    puts   "Pushing to `master' branch:"
    system "git add -A"
    system "git commit -m 'update at #{Time.now.utc}'"
    system "git push origin master"
    puts   "`master' branch updated."
  end
end

desc "Launch preview environment"
task :preview do
  system "bundle exec jekyll s --baseurl='/aboutac' --host='0.0.0.0'"
end

task :s => :preview
task :server => :preview
task :default => :preview
