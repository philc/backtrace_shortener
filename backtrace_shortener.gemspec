# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "backtrace_shortener/version"

Gem::Specification.new do |s|
  s.name        = "backtrace_shortener"
  s.version     = BacktraceShortener::VERSION
  s.authors     = ["Phil Crosby"]
  s.email       = ["phil.crosby@gmail.com"]
  s.homepage    = "http://github.com/philc/backtrace_shortener"
  s.summary     = "Shortens the backtraces of exceptions to make debugging more friendly."

  s.rubyforge_project = "backtrace_shortener"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
