# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/swagger/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-swagger"
  spec.version       = Rspec::Swagger::VERSION
  spec.authors       = ["Colin Rymer"]
  spec.email         = ["colin.rymer@gmail.com"]
  spec.summary       = %q{Generate Swagger docs from your specs.}
  spec.description   = %q{Generate Swagger docs from your specs.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
