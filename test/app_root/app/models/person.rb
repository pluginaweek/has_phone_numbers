class Person < ActiveRecord::Base
  has_one   :cell_phone,
              :class_name => 'PhoneNumber',
              :conditions => {:kind => 'cell'}
  has_one   :work_phone,
              :class_name => 'PhoneNumber',
              :conditions => {:kind => 'work'}
  has_many  :phone_numbers
end
