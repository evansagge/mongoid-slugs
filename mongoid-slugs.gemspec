# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/slugs/version'

Gem::Specification.new do |gem|
  gem.name          = "mongoid-slugs"
  gem.version       = Mongoid::Slugs::VERSION
  gem.authors       = ["Evan Sagge"]
  gem.email         = ["evansagge@gmail.com"]
  gem.homepage      = %q{http://github.com/evansagge/mongoid-slugs}
  gem.description   = %q{Simple slugging for Mongoid models}
  gem.summary       = %q{Simple slugging for Mongoid models}

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rake'
  gem.add_dependency 'mongoid', '>= 3.0.1'
  gem.add_dependency 'rspec', '>= 2.9'
end
