# Represents a phone number (most likely in the United States)
class PhoneNumber < ActiveRecord::Base
  belongs_to  :phoneable,
                :polymorphic => true
  
  validates_presence_of     :phoneable_id,
                            :phoneable_type,
                            :country_code,
                            :number
  validates_numericality_of :country_code,
                            :number
  validates_numericality_of :extension,
                              :allow_nil => true
  validates_length_of       :country_code,
                              :in => 1..3
  validates_length_of       :number,
                              :is => 10
  validates_length_of       :extension,
                              :maximum => 10,
                              :allow_nil => true
  
  def to_s #:nodoc
    human_number = "#{country_code}- #{number}"
    human_number << " ext. #{extension}" if extension
    
    human_number
  end
end
