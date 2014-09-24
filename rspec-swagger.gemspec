# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/swagger/version'

REQUIREMENT_LINE = "require 'rspec/swagger/tasks'\n"
RAKEFILE = 'Rakefile'

Gem::Specification.new do |spec|
  spec.name          = "rspec-swagger"
  spec.version       = Rspec::Swagger::VERSION
  spec.authors       = ["Colin Rymer", "Tyler Boyd", 'David Cole']
  spec.email         = ["colin.rymer@gmail.com", "tboyd47@gmail.com", 'davidhcole@gmail.com']
  spec.summary       = %q{Create Swagger docs and test them in your specs.}
  spec.description   = %q{Create Swagger docs and test them in your specs.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  Gem.post_install do
    if File.exists? RAKEFILE
      original_file = File.read RAKEFILE
      unless original_file.include?( REQUIREMENT_LINE )
        File.write RAKEFILE, "#{REQUIREMENT_LINE}#{original_file}"
      end
    end
  end
end