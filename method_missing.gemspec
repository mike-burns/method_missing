# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "method_missing/version"

Gem::Specification.new do |s|
  s.name        = "method_missing"
  s.version     = MethodMissing::VERSION
  s.authors     = ["Mike Burns"]
  s.email       = ["mike@mike-burns.com"]
  s.homepage    = ""
  s.license     = 'BSD'
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "method_missing"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rspec')
  s.add_development_dependency('rake')
end
