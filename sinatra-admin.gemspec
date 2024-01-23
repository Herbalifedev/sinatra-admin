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

  spec.add_development_dependency 'bundler',  '~> 2.5', '>= 2.5.5'
  spec.add_development_dependency 'rake',     '~> 13.1'
  spec.add_development_dependency 'rspec',    '~> 3.12'
  spec.add_development_dependency 'capybara', '~> 3.39', '>= 3.39.2'
  spec.add_development_dependency 'cucumber', '~> 9.1', '>= 9.1.1'
  spec.add_development_dependency 'cucumber-sinatra', '~> 0.5.0'
  spec.add_development_dependency 'database_cleaner', '~> 2.0', '>= 2.0.2'

  spec.add_dependency 'mongoid',         '~> 8.1', '>= 8.1.4'
  spec.add_dependency 'will_paginate_mongoid', '~> 2.0', '>= 2.0.1'
  spec.add_dependency 'sinatra',         '~> 4.0'
  spec.add_dependency 'sinatra-contrib', '~> 4.0'
  spec.add_dependency 'sinatra-flash',   '~> 0.3.0'
  spec.add_dependency 'haml',            '~> 6.3'
  spec.add_dependency 'warden',          '~> 1.2', '>= 1.2.9'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'bcrypt'
  spec.add_dependency 'dotenv'
  spec.add_dependency 'rack_csrf'
end
