require 'rubocop/rake_task'
require 'rake/testtask'

RuboCop::RakeTask.new(:lint) do |t|
  t.options = ['--display-cop-names']
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/test_*.rb']
end

desc 'run program'
task :start do
  ruby 'notepad.rb'
end
