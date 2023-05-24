# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'retscli/version'

Gem::Specification.new do |spec|
  spec.name          = "retscli"
  spec.version       = Retscli::VERSION
  spec.authors       = ["Ari Summer"]
  spec.email         = ["aribsummer@gmail.com"]

  spec.summary       = "CLI for querying RETS servers and searching metadata"
  spec.description   = "CLI for querying RETS servers and searching metadata"
  spec.homepage      = "http://github.com/summera/retscli"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rets", "~> 0.10"
  spec.add_dependency "thor"
  spec.add_dependency "terminal-table", "~> 1.5"
  spec.add_dependency "tty-spinner", "~> 0.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
