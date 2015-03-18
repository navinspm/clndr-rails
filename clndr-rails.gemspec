$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'clndr-rails/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'clndr-rails'
  s.version     = Clndr::Rails::VERSION
  s.authors     = ['Ilya Bondarenko']
  s.email       = ['bondarenko.ik@gmail.com']
  s.homepage    = 'http://kylestetz.github.io/CLNDR/'
  s.summary     = 'Asset gem for CLNDR.js'
  s.description = 'clndr-rails easy way to display calendar in your rails app'
  s.license     = 'MIT'

  s.files = Dir['{lib,vendor}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.0'
  s.add_dependency 'momentjs-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'underscore-rails'
  s.add_dependency 'railties', '~> 4.2.0'

  s.add_development_dependency 'sqlite3'
end
