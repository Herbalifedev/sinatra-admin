require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features SINATRA_ADMIN_SECRET='secret'"
end


namespace :test do
  desc 'Runs all specs.'
  task :all do |t|
    Rake.application["spec"].invoke
    Rake.application["features"].invoke
  end
end

task default: 'test:all'
