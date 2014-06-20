#encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iodized/version'

Gem::Specification.new do |spec|
  spec.name          = "iodized"
  spec.version       = Iodized::VERSION
  spec.authors       = ["Julian Doherty"]
  spec.email         = ["julian@envato.com"]
  spec.description   = %q{Iodine rich feature toggling. Lack of iodine can lead to development delays, and stunted growth.}
  spec.summary       = %q{iodized Ruby Client}
  spec.homepage      = "https://github.com/envato/iodized_ruby_client"
  spec.license       = "Copyright Envato - All rights reserved."

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",          "~> 1.3"
  spec.add_development_dependency "rspec",            ">= 2.12.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "sinatra"

  spec.add_dependency "thrift", "~> 0.9.1"
end
