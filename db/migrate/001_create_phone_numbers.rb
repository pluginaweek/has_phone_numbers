class CreatePhoneNumbers < ActiveRecord::Migration
  def self.up
    create_table :phone_numbers do |t|
      t.column :phoneable_id,   :integer,   :null => false, :unsigned => true, :references => nil
      # Default is the United States
      t.column :country_code,   :string,    :null => false, :limit => 3, :default => 1
      t.column :area_code,      :string,    :null => false, :limit => 4
      t.column :local_exchange, :string,    :null => false, :limit => 8
      t.column :extension,      :string,    :limit => 10
      t.column :created_at,     :timestamp, :null => false            
      t.column :updated_at,     :datetime,  :null => false
      t.column :deleted_at,     :datetime
      t.column :type,           :string,    :null => false
    end
  end
  
  def self.down
    drop_table :phone_numbers
  end
end
