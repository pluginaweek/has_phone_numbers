class CreatePhoneNumbers < ActiveRecord::Migration
  def self.up
    create_table :phone_numbers do |t|
      # Default is the United States
      t.column :country_code,   :string,  :limit => 3,  :null => false, :default => 1
      t.column :area_code,      :string,  :limit => 4,  :null => false
      t.column :local_exchange, :string,  :limit => 8,  :null => false
      t.column :extension,      :string,  :limit => 10
      t.column :created_at,     :timestamp,             :null => false
      t.column :updated_at,     :datetime,              :null => false
      t.column :deleted_at,     :datetime
    end
  end
  
  def self.down
    drop_table_if_exists :phone_numbers
  end
end
