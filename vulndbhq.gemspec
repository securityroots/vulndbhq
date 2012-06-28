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
end
