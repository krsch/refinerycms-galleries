Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-galleries'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Galleries engine for Refinery CMS'
  s.date              = '2011-12-16'
  s.summary           = 'Galleries engine for Refinery CMS'
  s.require_paths     = %w(lib)
  s.authors	      = %w(krsch)
  s.email             = %q{akrsch@gmail.com}
  s.homepage          = %q{http://github.com/krsch/refinerycms-galleries}
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*']
  s.add_dependency('rubyzip')
end
