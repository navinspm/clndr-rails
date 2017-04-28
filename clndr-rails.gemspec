$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'clndr-rails/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'clndr-rails'
  s.version     = Clndr::Rails::VERSION
  s.authors     = ['Navin Kumar']
  s.email       = ['navinspm@gmail.com']
  s.homepage    = 'https://github.com/navinspm/clndr-rails'
  s.summary     = 'Asset gem for CLNDR.js'
  s.description = 'clndr-rails easy way to display calendar in your Rails app'
  s.license     = 'MIT'

  s.files = Dir['{lib,vendor}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', ">= 4.1.0"
  s.add_dependency 'momentjs-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'underscore-rails'
  s.add_dependency "railties", ">= 4.1.0"

  s.add_development_dependency 'sqlite3'
end
