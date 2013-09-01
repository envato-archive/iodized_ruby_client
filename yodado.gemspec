#encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yodado/version'

Gem::Specification.new do |spec|
  spec.name          = "yodado"
  spec.version       = YodaDo::VERSION
  spec.authors       = ["Julian Doherty", "Anthony Sellitti"]
  spec.email         = ["julian.doherty@envato.com", "anthony.sellitti@envato.com"]
  spec.description   = %q{“Control, you have.”}
  spec.summary       = %q{Yodado Ruby Client}
  spec.homepage      = "https://github.com/envato/yodado_ruby_client"
  spec.license       = "Copyright Envato - All rights reserved."

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",          "~> 1.3"
  spec.add_development_dependency "rspec",            ">= 2.12.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-debugger"
  spec.add_development_dependency "pry-doc"
  spec.add_development_dependency "rake"
end