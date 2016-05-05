# encoding: utf-8
begin
  require 'bundler/setup'
  require 'bundler/gem_tasks'
rescue
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require './lib/simple_mapnik/api.rb'

RuboCop::RakeTask.new(:rubocop) do |task|
  task.requires << 'rubocop-rspec'
  task.fail_on_error = true
end
task spec: :rubocop do
  RSpec::Core::RakeTask.new(:spec)
end

task :install do
  SimpleMapnik::Api.new.install
end

task default: :install

task '2>&1' => :default
