# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara/bootstrap/version'

Gem::Specification.new do |spec|
  spec.name          = 'capybara-bootstrap'
  spec.version       = Capybara::Bootstrap::VERSION
  spec.authors       = ['Erran Carey']
  spec.email         = ['me@errancarey.com']
  spec.summary       = %q{A set of models mapped to bootstrap UI elements for Capybara}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'capybara'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'selenium-webdriver'
end
