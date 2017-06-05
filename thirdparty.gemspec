# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thirdparty/version'

Gem::Specification.new do |spec|
  spec.name          = "thirdparty"
  spec.version       = Thirdparty::VERSION
  spec.authors       = ["Peter Graham"]
  spec.email         = ["peter@wealthsimple.com"]

  spec.summary       = %q{Rubygem for making API calls to Thirdparty.com}
  spec.description   = %q{Rubygem for making REST API calls to Thirdparty.com Trade API.}
  spec.homepage      = "https://github.com/wealthsimple/thirdparty"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 4"
  spec.add_dependency "dotenv"
  spec.add_dependency "faraday", "0.12.1"
  spec.add_dependency "recursive-open-struct"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.2"
  spec.add_development_dependency "webmock", "~> 3.0"
end
