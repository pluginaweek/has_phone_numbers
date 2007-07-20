class AddPhoneNumberKinds < ActiveRecord::Migration
  def self.up
    add_column :phone_numbers, :kind, :string
  end
  
  def self.down
    remove_column :phone_numbers, :kind, :string
  end
end
