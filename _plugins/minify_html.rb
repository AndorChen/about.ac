Jekyll::Hooks.register :site, :post_write do |site|
  # Minify HTML files after site build
  gulp = File.join(site.source, 'node_modules', '.bin', 'gulp')
  system "#{gulp} minifyHTML --silent"
end
