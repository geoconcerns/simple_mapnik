# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ffi-mapnik/version'

Gem::Specification.new do |gem|
  gem.name = 'ffi-mapnik'
  gem.version = Mapnik::VERSION
  gem.description = 'FFI wrapper for Mapnik'
  gem.summary = 'Convenient access to Mapnik from Ruby'
  gem.licenses = ['MIT']

  gem.authors = ['Scooter Wadsworth']
  gem.email = ['scooterwadsworth@gmail.com']
  gem.homepage = 'https://github.com/scooterw/ffi-mapnik'

  gem.required_ruby_version = '>= 1.9.2'
  gem.required_rubygems_version = '>= 1.3.6'

  gem.files = Dir['README.md', 'bin/**/*', 'lib/**/*', 'libmapnik_c.dylib']
  gem.require_paths = ['lib']
  gem.bindir = 'bin'
  gem.executables = ['mapnik_console']

  gem.add_dependency 'ffi', '~> 1.9.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
end
