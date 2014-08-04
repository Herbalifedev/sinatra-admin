# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra-admin/version'

Gem::Specification.new do |spec|
  spec.name          = 'sinatra-admin'
  spec.version       = SinatraAdmin::VERSION
  spec.authors       = ['Fco. Delgado']
  spec.email         = ['franciscodelgadodev@gmail.com']
  spec.summary       = "Rack Middleware inpired in ActiveAdmin for Sinatra applications. Allow us to build an admin dashboard with a minimal effort."
  spec.homepage      = 'https://github.com/Herbalifedev/sinatra-admin'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",  "~> 1.6"
  spec.add_development_dependency "rake",     "~> 10.0"
  spec.add_development_dependency "rspec",    "~> 3.0.0"

  spec.add_dependency "sinatra"
  spec.add_dependency 'sinatra-contrib'
  spec.add_dependency 'haml',           '~> 4.0.5'
  spec.add_dependency 'activesupport',  '~> 4.0.0'
end
