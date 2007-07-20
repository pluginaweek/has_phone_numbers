require File.dirname(__FILE__) + '/../test_helper'

class HasPhoneNumbersTest < Test::Unit::TestCase
  fixtures :phone_numbers, :people
  
  def test_should_create_one_association
    assert_equal phone_numbers(:cell), people(:john_doe).cell_phone
    assert_equal phone_numbers(:work), people(:john_doe).work_phone
  end
  
  def test_should_create_many_association
    assert_equal 2, people(:john_doe).phone_numbers.size
    assert_equal [], [phone_numbers(:cell), phone_numbers(:work)] - people(:john_doe).phone_numbers
  end
end