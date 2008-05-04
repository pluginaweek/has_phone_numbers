class MigrateHasPhoneNumbersToVersion1 < ActiveRecord::Migration
  def self.up
    Rails::Plugin.find(:has_phone_numbers).migrate(1)
  end
  
  def self.down
    Rails::Plugin.find(:has_phone_numbers).migrate(0)
  end
end
