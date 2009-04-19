require File.dirname(__FILE__) + '/../test_helper'

class PhoneNumberByDefaultTest < Test::Unit::TestCase
  def setup
    @phone_number = PhoneNumber.new
  end
  
  def test_should_not_have_a_phoneable_id
    assert_nil @phone_number.phoneable_id
  end
  
  def test_should_not_have_a_phoneable_type
    assert @phone_number.phoneable_type.blank?
  end
  
  def test_should_a_united_states_country_code
    assert_equal '1', @phone_number.country_code
  end
  
  def test_should_not_have_a_number
    assert @phone_number.number.blank?
  end
  
  def test_should_not_have_an_extension
    assert @phone_number.extension.blank?
  end
end

class PhoneNumberTest < Test::Unit::TestCase
  def test_should_be_valid_with_a_set_of_valid_attributes
    phone_number = new_phone_number
    assert phone_number.valid?
  end
  
  def test_should_require_a_phoneable_id
    phone_number = new_phone_number(:phoneable => nil, :phoneable_id => nil)
    assert !phone_number.valid?
    assert phone_number.errors.invalid?(:phoneable_id)
  end
  
  def test_should_require_a_phoneable_type
    phone_number = new_phone_number(:phoneable => nil, :phoneable_type => nil)
    assert !phone_number.valid?
    assert phone_number.errors.invalid?(:phoneable_type)
  end
  
  def test_should_require_a_country_code
    phone_number = new_phone_number(:country_code => nil)
    assert !phone_number.valid?
    assert phone_number.errors.invalid?(:country_code)
  end
  
  def test_should_require_country_code_be_a_number
    phone_number = new_phone_number(:country_code => 'a')
    assert !phone_number.valid?
    assert phone_number.errors.invalid?(:country_code)
  end
  
  def test_should_require_country_codes_be_between_1_and_3_numbers
    phone_number = new_phone_number(:country_code => '')
    assert !phone_number.valid?
    assert phone_number.errors.invalid?(:country_code)
    
    phone_number.country_code += '1'
    assert phone_number.valid?
    
    phone_number.country_code += '11'
    assert phone_number.valid?
    
    phone_number.country_code += '1'
    assert !phone_number.valid?
    assert phone_number.errors.invalid?(:country_code)
  end
  
  def test_should_require_a_number
    phone_number = new_phone_number(:number => nil)
    assert !phone_number.valid?
    assert phone_number.errors.invalid?(:number)
  end
  
  def test_should_require_number_be_a_number
    phone_number = new_phone_number(:number => 'a' * 10)
    assert !phone_number.valid?
    assert phone_number.errors.invalid?(:number)
  end
  
  def test_should_require_number_be_exactly_10_numbers
    phone_number = new_phone_number(:number => '1' * 9)
    assert !phone_number.valid?
    assert phone_number.errors.invalid?(:number)
    
    phone_number.number += '1'
    assert phone_number.valid?
    
    phone_number.number += '1'
    assert !phone_number.valid?
    assert phone_number.errors.invalid?(:number)
  end
  
  def test_should_not_require_an_extension
    phone_number = new_phone_number(:extension => nil)
    assert phone_number.valid?
  end
  
  def test_should_require_extension_be_at_most_10_numbers
    phone_number = new_phone_number(:extension => '1' * 9)
    assert phone_number.valid?
    
    phone_number.extension += '1'
    assert phone_number.valid?
    
    phone_number.extension += '1'
    assert !phone_number.valid?
    assert phone_number.errors.invalid?(:extension)
  end
  
  def test_should_protect_attributes_from_mass_assignment
    phone_number = PhoneNumber.new(
      :id => 1,
      :phoneable_id => 1,
      :phoneable_type => 'User',
      :country_code => '123',
      :number => '8675309',
      :extension => '999'
    )
    
    assert_nil phone_number.id
    assert_equal 1, phone_number.phoneable_id
    assert_equal 'User', phone_number.phoneable_type
    assert_equal '123', phone_number.country_code
    assert_equal '8675309', phone_number.number
    assert_equal '999', phone_number.extension
  end
end

class PhoneNumberAfterBeingCreatedTest < Test::Unit::TestCase
  def setup
    @person = create_person
    @phone_number = create_phone_number(:phoneable => @person, :country_code => '1', :number => '1234567890')
  end
  
  def test_should_record_when_it_was_created
    assert_not_nil @phone_number.created_at
  end
  
  def test_should_record_when_it_was_updated
    assert_not_nil @phone_number.updated_at
  end
  
  def test_should_have_a_phoneable_association
    assert_equal @person, @phone_number.phoneable
  end
end
