#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'

desc "Run RSpec"
RSpec::Core::RakeTask.new do |t|
  t.verbose = false
end

task :default => :spec