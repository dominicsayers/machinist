lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'machinist/version'

Gem::Specification.new do |gem|
  gem.name          = 'machinist_redux'
  gem.version       = Machinist::VERSION
  gem.authors       = ['Pete Yandell', 'Attila Györffy', 'Dominic Sayers']
  gem.email         = ['dominic@sayers.cc']
  gem.description   = 'Machinist makes it easy to create objects for use in tests. It generates data for the ' \
                      "attributes you don't care about, and constructs any necessary associated objects, leaving you "\
                      'to specify only the fields you care about in your test.'
  gem.summary       = "Fixtures aren't fun. Machinist was."
  gem.homepage      = 'http://github.com/dominicsayers/machinist'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
