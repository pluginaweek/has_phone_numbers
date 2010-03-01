class CreatePhoneNumbers < ActiveRecord::Migration
  def self.up
    create_table :phone_numbers do |t|
      t.references :phoneable, :polymorphic => true, :null => false
      t.string :country_code, :null => false, :limit => 3, :default => 1 # Default is the United States
      t.string :number, :null => false, :limit => 12
      t.string :extension, :limit => 10
      t.timestamps
    end
  end
  
  def self.down
    drop_table :phone_numbers
  end
end
