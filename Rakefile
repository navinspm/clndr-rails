require "bundler/gem_tasks"

require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('test/spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
end
task :default => :spec