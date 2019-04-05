# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

if Rails.env.in?(%w[development test])
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new(:rubocop) do |task|
    task.patterns = %w[{app,lib}/**/*.rb]
  end
end

if Rails.env.development?
  Annotate.load_tasks
end
