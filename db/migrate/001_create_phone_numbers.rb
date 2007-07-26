class CreatePhoneNumbers < ActiveRecord::Migration
  def self.up
    create_table :phone_numbers do |t|
      t.column :phoneable_id, :integer, :null => false, :references => nil
      t.column :phoneable_type, :string, :null => false
      # Default is the United States
      t.column :country_code, :string, :null => false, :limit => 3, :default => 1
      t.column :number, :string, :null => false, :limit => 12
      t.column :extension, :string, :limit => 10
      t.column :created_at, :timestamp, :null => false            
      t.column :updated_at, :datetime, :null => false
    end
  end
  
  def self.down
    drop_table :phone_numbers
  end
end
