# Represents a phone number
class PhoneNumber < ActiveRecord::Base
  belongs_to                :phoneable,
                              :polymorphic => true
  
  validates_presence_of     :phoneable_id,
                            :phoneable_type,
                            :country_code,
                            :number
  
  with_options(:allow_nil => true) do |klass|
    klass.validates_numericality_of :country_code,
                                    :number,
                                    :extension
    klass.validates_length_of       :country_code,
                                      :in => 1..3
    klass.validates_length_of       :number,
                                      :is => 10
    klass.validates_length_of       :extension,
                                      :maximum => 10
  end
  
  def to_s #:nodoc
    human_number = "#{country_code}- #{number}"
    human_number << " ext. #{extension}" if extension
    
    human_number
  end
end