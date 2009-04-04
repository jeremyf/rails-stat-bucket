require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'
require "rake/testtask"

GEM = "rails-stat-bucket"
GEM_VERSION = "0.4.0"
AUTHOR = "Jeremy Friesen"
EMAIL = "reclusive.geek@gmail.com"
HOMEPAGE = "http://github.com/jeremyf/rails-stat-bucket"
SUMMARY = "A simple gem that will traverse your Git history and report the rails stats for each day in the projects life."

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.bindir = 'bin'
  s.executables = GEM
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  
  s.add_dependency("main", ">=2.8.3"
  
  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,test,bin}/**/*")
end

task :default => :test

desc "Run tests"
Rake::TestTask.new do |test|
  test.libs       << "test"
  test.test_files =  [ "test/**/*_test.rb" ]
  test.verbose    =  true
end


Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end