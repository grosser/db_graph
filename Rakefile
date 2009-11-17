task :default => :spec
require 'spec/rake/spectask'
Spec::Rake::SpecTask.new {|t| t.spec_opts = ['--color']}

begin
  require 'jeweler'
  project_name = 'db_graph'
  Jeweler::Tasks.new do |gem|
    gem.name = project_name
    gem.summary = "AR generate beautiful graphs from date fields, in 1 LOC"
    gem.email = "grosser.michael@gmail.com"
    gem.homepage = "http://github.com/grosser/#{project_name}"
    gem.authors = ["Michael Grosser"]
    gem.add_dependency ['gchartrb']
    gem.add_dependency ['activesupport']
    gem.add_dependency ['activerecord']
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end