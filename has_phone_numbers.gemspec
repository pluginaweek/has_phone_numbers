# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{has_phone_numbers}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Pfeifer"]
  s.date = %q{2009-06-08}
  s.description = %q{Demonstrates a reference implementation for handling phone numbers in ActiveRecord}
  s.email = %q{aaron@pluginaweek.org}
  s.files = ["app/models", "app/models/phone_number.rb", "db/migrate", "db/migrate/001_create_phone_numbers.rb", "lib/has_phone_numbers.rb", "test/unit", "test/unit/phone_number_test.rb", "test/factory.rb", "test/app_root", "test/app_root/app", "test/app_root/app/models", "test/app_root/app/models/person.rb", "test/app_root/db", "test/app_root/db/migrate", "test/app_root/db/migrate/002_migrate_has_phone_numbers_to_version_1.rb", "test/app_root/db/migrate/001_create_people.rb", "test/test_helper.rb", "test/functional", "test/functional/has_phone_numbers_test.rb", "CHANGELOG.rdoc", "init.rb", "LICENSE", "Rakefile", "README.rdoc"]
  s.has_rdoc = true
  s.homepage = %q{http://www.pluginaweek.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pluginaweek}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Demonstrates a reference implementation for handling phone numbers in ActiveRecord}
  s.test_files = ["test/unit/phone_number_test.rb", "test/functional/has_phone_numbers_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
