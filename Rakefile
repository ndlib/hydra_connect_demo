# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :spec do
  RSpec::Core::RakeTask.new(:all) do
    ENV['COVERAGE'] = 'true'
  end

  desc 'Run the Travis CI specs'
  task :travis do
    ENV['RAILS_ENV'] = 'test'
    spec_helper = File.expand_path('../spec/rails_helper.rb', __FILE__)
    ENV['SPEC_OPTS'] = "--profile 5 --require #{spec_helper}"
    Rake::Task['spec:all'].invoke
  end
end

Rake::Task['spec'].clear

task spec: 'spec:all'
task default: 'spec:travis'
