require 'yaml'

PWD = File.expand_path('../', __FILE__)

desc 'Deploy to ftp via git-ftp'
task :deploy do
  options = YAML.load_file(File.join(PWD, '_ftp.yml'))
  user = options['ftp_username']
  passwd = options['ftp_password']
  host = options['ftp_host'].chomp('/')
  port = options['ftp_port'] || 21
  dir = options['ftp_dir'].start_with?('/') ? options['ftp_dir'][1..-1] : options['ftp_dir']

  system "bundle exec jekyll build"
  puts
  cd '_site' do
    system "git add -A"
    system "git commit -m 'update at #{Time.now.utc}'"
    puts
    system "git ftp push --user #{user} --passwd #{passwd} ftp://#{host}:#{port}/#{dir}"
  end
end

desc "Launch preview environment"
task :preview do
  system "bundle exec jekyll s --drafts --baseurl='/aboutac' --host='0.0.0.0'"
end

task :s => :preview
task :server => :preview
task :default => :preview
