# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "growl_notify_osascript"

Gem::Specification.new do |s|
  #s.name        = "growl_notify_osascript"
  s.name        = "growl_notify_osascript"
  s.version     = GrowlNotifyOsascript::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Inge Jørgensen"]
  s.email       = ["inge@elektronaut.no"]
  s.homepage    = "https://github.com/elektronaut/growl_notify_osascript"
  s.summary     = %q{Port of Sam Davis' growl_notify gem without the Appscript dependency}
  s.description = %q{Port of Sam Davis' growl_notify gem without the Appscript dependency}

  s.rubyforge_project = "growl_notify_osascript"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'mocha'
    
end
