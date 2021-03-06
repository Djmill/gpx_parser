# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gpx_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "gpx_parser"
  spec.version       = GpxParser::VERSION
  spec.authors       = ["David Miller"]
  spec.email         = ["djmdev24@gmail.com"]

  spec.summary       = "Write a short summary, because Rubygems requires one"
  spec.description   = "Write a longer description or delete this line."
  spec.homepage      = "https://github.com/djmill/gpx_parser"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
