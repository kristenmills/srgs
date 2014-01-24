# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'srgs_builder/version'

Gem::Specification.new do |spec|
  spec.name          = "srgs_builder"
  spec.version       = SrgsBuilder::VERSION
  spec.authors       = ["kristenmills"]
  spec.email         = ["kristen@kristen-mills.com"]
  spec.description   = "A gem for building SRGS/grXML documents."
  spec.summary       = "A gem for building SRGS/grXML documents."
  spec.homepage      = "https://github.com/kristenmills/srgs_builder"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "nokogiri"
end
