# -*- encoding: utf-8 -*-
require File.expand_path('../lib/vulndbhq/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Daniel Martin']
  gem.email         = ['<daniel@securityroots.com>']
  gem.description   = %q{A Ruby wrapper for the VulnDB HQ API.}
  gem.summary       = %q{VulnDB HQ API wrapper}
  gem.homepage      = 'http://vulndbhq.com'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'vulndbhq'
  gem.require_paths = ['lib']
  gem.version       = VulnDBHQ::Version

  gem.add_runtime_dependency 'faraday', '~> 0.8'
  gem.add_runtime_dependency 'multi_json', '~> 1.3'

  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rspec', '~> 2.8'
  gem.add_development_dependency 'webmock'
end
