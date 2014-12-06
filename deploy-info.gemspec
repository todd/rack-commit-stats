# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'deploy-info/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency 'rugged', '~> 0.21.0'
  spec.add_dependency 'rack',   '~> 1.0'
  spec.add_development_dependency 'bundler', '~> 1.0'

  spec.authors       = ['Todd Bealmear']
  spec.description   = %q{Get deployment details for your Ruby application.}
  spec.email         = ['todd@t0dd.io']
  spec.files         = %w(LICENSE README.md Rakefile deploy-info.gemspec)
  spec.files        += Dir.glob('lib/**/*.rb')
  spec.files        += Dir.glob('spec/**/*')
  spec.homepage      = 'https://github.com/todd/deploy-info'
  spec.licenses      = ['MIT']
  spec.name          = 'deploy-info'
  spec.require_paths = ['lib']
  spec.summary       = spec.description
  spec.version       = DeployInfo::VERSION
end
