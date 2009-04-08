# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails-stat-bucket}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeremy Friesen"]
  s.autorequire = %q{rails-stat-bucket}
  s.date = %q{2009-04-07}
  s.default_executable = %q{rails-stat-bucket}
  s.description = %q{A simple gem that will traverse your Git history and report the rails stats for each day in the projects life.}
  s.email = %q{reclusive.geek@gmail.com}
  s.executables = ["rails-stat-bucket"]
  s.extra_rdoc_files = ["README.textile", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README.textile", "Rakefile", "TODO", "lib/rails-stat-bucket.rb", "test/rails-stat-bucket_test.rb", "test/test_helper.rb", "bin/rails-stat-bucket"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/jeremyf/rails-stat-bucket}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A simple gem that will traverse your Git history and report the rails stats for each day in the projects life.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<main>, [">= 2.8.3"])
    else
      s.add_dependency(%q<main>, [">= 2.8.3"])
    end
  else
    s.add_dependency(%q<main>, [">= 2.8.3"])
  end
end
