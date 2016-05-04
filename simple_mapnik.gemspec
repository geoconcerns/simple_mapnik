# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_mapnik/version'

Gem::Specification.new do |spec|
  spec.name = 'simple_mapnik'
  spec.version = Mapnik::VERSION
  spec.description = 'Simple FFI wrapper for Mapnik'
  spec.summary = 'Simple access to Mapnik library from Ruby'
  spec.license = 'MIT'

  spec.authors = ['Eliot Jordan']
  spec.email = ['eliotj@princeton.edu']
  spec.homepage = 'https://github.com/geoconcerns/simple_mapnik'

  spec.required_ruby_version = '>= 1.9.2'
  spec.required_rubygems_version = '>= 1.3.6'

  spec.files = Dir['README.md', 'lib/**/*', 'ext/**/*']
  spec.require_paths = ['lib']
  spec.bindir = 'bin'
  spec.executables = ['mapnik_console']
  spec.extensions = ['Rakefile']

  spec.add_dependency 'ffi', '~> 1.9.0'
  spec.add_dependency 'rubyzip', '~> 1.2.0'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop', '~> 0.39'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.4.1'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'byebug'
end
