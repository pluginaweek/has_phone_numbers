# Represents a phone number split into multiple parts:
# * +country_code+ - Uniquely identifiers the country to which the number belongs.
#   This value is based on the E.164 standard (http://en.wikipedia.org/wiki/E.164)
# * +number+ - The subscriber number (10 digits in length)
# * +extension+ - A number that can route to different phones at a location
# 
# This phone number format is biased towards those types found in the United
# States and may need to be adjusted for international support.
class PhoneNumber < ActiveRecord::Base
  belongs_to :phoneable, :polymorphic => true
  
  validates_presence_of :phoneable_id, :phoneable_type, :country_code, :number
  validates_numericality_of :country_code, :number
  validates_numericality_of :extension, :allow_nil => true
  validates_length_of :country_code, :in => 1..3
  validates_length_of :number, :is => 10
  validates_length_of :extension, :maximum => 10, :allow_nil => true
  
  # Generates a human-readable version of the phone number, based on all of the
  # various parts of the number.
  # 
  # For example,
  # 
  #   phone = PhoneNumber.new(:country_code => '1', :number => '123-456-7890')
  #   phone.display_value     # => "1- 123-456-7890"
  #   phone.extension = "123"
  #   phone.display_value     # => "1- 123-456-7890 ext. 123"
  def display_value
    human_number = "#{country_code}- #{number}"
    human_number << " ext. #{extension}" if extension
    human_number
  end
end
