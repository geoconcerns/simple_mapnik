# encoding: utf-8
begin
  require 'bundler/setup'
  require 'bundler/gem_tasks'
rescue
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rspec/core/rake_task'
require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.requires << 'rubocop-rspec'
  task.fail_on_error = true
end
task spec: :rubocop do
  RSpec::Core::RakeTask.new(:spec)
end

task default: :prepare

task :prepare do
  system("make -C ext && mv ext/$(ls ext/ | grep -E '(.dylib|.so)') .")
end

task '2>&1' => :default
