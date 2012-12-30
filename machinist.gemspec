# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'machinist/version'

Gem::Specification.new do |gem|
  gem.name          = "machinist"
  gem.version       = Machinist::VERSION
  gem.authors       = ["Pete Yandell", "Attila Györffy"]
  gem.email         = ["attila@attilagyorffy.com"]
  gem.description   = %q{Machinist makes it easy to create objects for use in tests. It generates data for the attributes you don't care about, and constructs any necessary associated objects, leaving you to specify only the fields you care about in your test.}
  gem.summary       = %q{Fixtures aren't fun. Machinist is.}
  gem.homepage      = "http://github.com/liquid/machinist"

  gem.add_development_dependency "activerecord"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rdoc"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
