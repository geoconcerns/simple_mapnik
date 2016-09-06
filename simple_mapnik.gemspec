# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_mapnik/version'

Gem::Specification.new do |spec|
  spec.name = 'simple_mapnik'
  spec.version = SimpleMapnik::VERSION
  spec.authors = ['Eliot Jordan']
  spec.email = ['eliotj@princeton.edu']
  spec.description = 'Simple FFI wrapper for Mapnik'
  spec.summary = 'Simple access to Mapnik library from Ruby'
  spec.homepage = 'https://github.com/geoconcerns/simple_mapnik'
  spec.license = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.extensions = ['Rakefile']

  spec.add_dependency 'ffi', '~> 1.9.0'
  spec.add_dependency 'rubyzip', '~> 1.2.0'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'rake'
  spec.add_dependency 'bundler', '~> 1.12'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop', '~> 0.39'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.4.1'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
end
