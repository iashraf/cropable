# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cropable/version'

Gem::Specification.new do |spec|
  spec.name          = "cropable"
  spec.version       = Cropable::VERSION
  spec.authors       = ["Richard Kimber"]
  spec.email         = ["richard@dogma.co.uk"]
  spec.description   = %q{Cropable description}
  spec.summary       = %q{Cropable summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
