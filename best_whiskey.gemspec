# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'best_whiskey/version'

Gem::Specification.new do |spec|
  spec.name          = "best_whiskey"
  spec.version       = BestWhiskey::VERSION
  spec.authors       = ["Brett Heenan"]
  spec.email         = ["brettrheenan@gmail.com"]

  spec.summary       = %q{A CLI gem that lists the best whiskies of the year}
  spec.description   = %q{Check out info and descriptions of the winner's of the best whisky of the year in several categories}
  spec.homepage      = "https://github.com/ryuichi7/best_whiskey.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["best_whiskey"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
