class Person < ActiveRecord::Base
  has_phone_number  :cell_phone,
                      :conditions => ['phone_numbers.kind = ?', 'cell']
  has_phone_number  :work_phone,
                      :conditions => ['phone_numbers.kind = ?', 'work']
  has_phone_numbers :phone_numbers
end