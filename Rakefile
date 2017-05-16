begin
  require 'rubygems'
  require 'bundler/setup'
  require 'bundler/gem_tasks'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task default: :spec
rescue LoadError
  puts 'rspec is not available'
end

require 'rdoc/task'
RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'Machinist'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('lib')
end
