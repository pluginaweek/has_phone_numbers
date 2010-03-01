class HasPhoneNumbersGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template '001_create_phone_numbers.rb', 'db/migrate', :migration_file_name => 'create_phone_numbers'
    end
  end
end
