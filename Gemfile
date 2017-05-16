source 'http://rubygems.org'
gemspec
ruby RUBY_VERSION

group :development do
  gem 'appraisal', require: false
  gem 'rdoc', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'codeclimate-test-reporter', require: false
  gem 'coveralls', require: false
  gem 'fuubar', require: false
  gem 'rspec', require: false
  gem 'rspec_junit_formatter', require: false
  gem 'simplecov', '~> 0.14', require: false
end

platforms :ruby do
  gem 'sqlite3'
end

platforms :jruby do
  gem 'activerecord-jdbcsqlite3-adapter'
end
