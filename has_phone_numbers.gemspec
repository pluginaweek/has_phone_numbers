$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'has_phone_numbers/version'

Gem::Specification.new do |s|
  s.name              = "has_phone_numbers"
  s.version           = HasPhoneNumbers::VERSION
  s.authors           = ["Aaron Pfeifer"]
  s.email             = "aaron@pluginaweek.org"
  s.homepage          = "http://www.pluginaweek.org"
  s.description       = "Demonstrates a reference implementation for handling phone numbers in ActiveRecord"
  s.summary           = "Phone numbers in ActiveRecord"
  s.require_paths     = ["lib"]
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- test/*`.split("\n")
  s.rdoc_options      = %w(--line-numbers --inline-source --title has_phone_numbers --main README.rdoc)
  s.extra_rdoc_files  = %w(README.rdoc CHANGELOG.rdoc LICENSE)
end
