# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "method_missing/version"

Gem::Specification.new do |s|
  s.name        = "method_missing"
  s.version     = MethodMissing::VERSION
  s.authors     = ["Mike Burns"]
  s.email       = ["mike@mike-burns.com"]
  s.homepage    = "http://github.com/mike-burns/method_missing"
  s.license     = 'BSD'
  s.summary     = %q{Compose, sequence, and repeat Ruby methods.}
  s.description = %q{
    The methods on methods that you've been missing.

    This gem adds the #* #/ and #^ methods so you can compose, sequence, and
    repeat methods.

    By composing methods you can express that one method calls another more
    obviously.

    By sequencing methods you can express that a series of methods have the
    same argument more succinctly.

    By repeating a method you can compose it with itself as needed, to build
    upon itself.
  }

  s.rubyforge_project = "method_missing"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rspec')
  s.add_development_dependency('rake')
end
