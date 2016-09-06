# encoding: utf-8
require 'bundler/setup'
require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new(:rubocop) do |task|
    task.requires << 'rubocop-rspec'
    task.fail_on_error = true
  end
  task spec: :rubocop do
    RSpec::Core::RakeTask.new(:spec)
  end
rescue LoadError
end

require './lib/simple_mapnik/api.rb'
require 'ffi'

namespace :api do
  desc 'check for mapnik c api and install'
  task :check_and_install do
    SimpleMapnik::Api.new.check_and_install
  end

  desc 'build mapnik c api'
  task :build do
    SimpleMapnik::Api.new.install
  end
end

task default: ['api:build']
