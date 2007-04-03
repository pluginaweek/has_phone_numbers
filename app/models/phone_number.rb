# Represents a phone number
class PhoneNumber < ActiveRecord::Base
  belongs_to                :phoneable,
                              :polymorphic => true
                              
  validates_presence_of     :phoneable_id,
                            :phoneable_type,
                            :country_code,
                            :area_code,
                            :local_exchange
                            
  validates_numericality_of :country_code,
                            :area_code,
                            :local_exchange,
                            :extension
                            
  validates_length_of       :country_code,
                              :in => 1..3
  validates_length_of       :area_code,
                              :in => 2..4
  validates_length_of       :local_exchange,
                              :in => 6..8
  validates_length_of       :extension,
                              :maximum => 10
  
  def to_s #:nodoc
    "#{country_code}- (#{area_code}) #{local_exchange}"
  end
end