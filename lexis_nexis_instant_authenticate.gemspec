# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lexis_nexis_instant_authenticate/version'

Gem::Specification.new do |spec|
  spec.name          = "lexis_nexis_instant_authenticate"
  spec.version       = LexisNexisInstantAuthenticate::VERSION
  spec.authors       = ["Christopher Ostrowski"]
  spec.email         = ["chris@reppro.co"]

  spec.summary       = %q{Ruby interface for using LexisNexis Instant Authenticate.}
  spec.homepage      = "https://github.com/reppro/lexis_nexis_instant_authenticate"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_dependency 'savon', '~> 2.0'
  spec.add_dependency 'gyoku'
end
