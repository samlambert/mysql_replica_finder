# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mysql_replica_finder/version'

Gem::Specification.new do |spec|
  spec.name          = "mysql_replica_finder"
  spec.version       = MysqlReplicaFinder::VERSION
  spec.authors       = ["Sam Lambert"]
  spec.email         = ["sam.lambert@github.com"]
  spec.summary       = "Get replicas from mysql2 connection"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mysql2"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
