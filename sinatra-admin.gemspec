# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra-admin/version'

Gem::Specification.new do |spec|
  spec.name          = 'sinatra-admin'
  spec.version       = SinatraAdmin::VERSION
  spec.authors       = ['Fco. Delgado', 'Carlo Cajucom', 'Vahak Matavosian']
  spec.email         = ['franciscodelgadodev@gmail.com']
  spec.summary       = "Sinatra application that allow us to have an admin dashboard with minimal effort."
  spec.homepage      = 'https://github.com/Herbalifedev/sinatra-admin'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler',  '>= 2.1.0'
  spec.add_development_dependency 'rake',     '~> 12.3.3'
  spec.add_development_dependency 'rspec',    '~> 3.0.0'
  spec.add_development_dependency 'capybara', '~> 2.4.1'
  spec.add_development_dependency 'cucumber', '~> 1.3.16'
  spec.add_development_dependency 'cucumber-sinatra', '~> 0.5.0'
  spec.add_development_dependency 'database_cleaner', '1.3.0'

  spec.add_dependency 'mongoid',         '~> 3.1.6'
  spec.add_dependency 'will_paginate_mongoid', '~> 2.0.1'
  spec.add_dependency 'sinatra',         '~> 1.4.5'
  spec.add_dependency 'sinatra-contrib', '~> 1.4.2'
  spec.add_dependency 'sinatra-flash',   '~> 0.3.0'
  spec.add_dependency 'haml',            '~> 5.0.0'
  spec.add_dependency 'warden',          '~> 1.2.3'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'bcrypt'
  spec.add_dependency 'dotenv'
  spec.add_dependency 'rack_csrf'
end
