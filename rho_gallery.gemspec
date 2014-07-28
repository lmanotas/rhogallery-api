# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'rho_gallery/version'

Gem::Specification.new do |s|
  s.name        = "rhogallery"
  s.version     = Rhogallery::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rhomobile"]
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.email       = ["support@rhomobile.com"]
  s.homepage    = %q{http://rhomobile.com}
  s.summary     = %q{RhoGallery client}
  s.description = %q{RhoGallery api client }

  s.rubyforge_project = nil  
  s.add_dependency('json', '~>1.5.4')
  s.add_dependency('activeresource', '~>4.0.0')
  s.add_development_dependency 'rspec', '~> 3.0.0'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
end