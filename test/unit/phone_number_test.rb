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
    phone_number = new_phone_number(:phoneable_id => nil)
    assert !phone_number.valid?
    assert_equal 1, Array(phone_number.errors.on(:phoneable_id)).size
  end
  
  def test_should_require_a_phoneable_type
    phone_number = new_phone_number(:phoneable_type => nil)
    assert !phone_number.valid?
    assert_equal 1, Array(phone_number.errors.on(:phoneable_type)).size
  end
  
  def test_should_require_a_country_code
    phone_number = new_phone_number(:country_code => nil)
    assert !phone_number.valid?
    assert_equal 3, Array(phone_number.errors.on(:country_code)).size
  end
  
  def test_should_require_country_code_be_a_number
    phone_number = new_phone_number(:country_code => 'a')
    assert !phone_number.valid?
    assert_equal 1, Array(phone_number.errors.on(:country_code)).size
  end
  
  def test_should_require_country_codes_be_between_1_and_3_numbers
    phone_number = new_phone_number(:country_code => '')
    assert !phone_number.valid?
    assert_equal 3, Array(phone_number.errors.on(:country_code)).size
    
    phone_number.country_code += '1'
    assert phone_number.valid?
    
    phone_number.country_code += '11'
    assert phone_number.valid?
    
    phone_number.country_code += '1'
    assert !phone_number.valid?
    assert_equal 1, Array(phone_number.errors.on(:country_code)).size
  end
  
  def test_should_require_a_number
    phone_number = new_phone_number(:number => nil)
    assert !phone_number.valid?
    assert_equal 3, Array(phone_number.errors.on(:number)).size
  end
  
  def test_should_require_number_be_a_number
    phone_number = new_phone_number(:number => 'a' * 10)
    assert !phone_number.valid?
    assert_equal 1, Array(phone_number.errors.on(:number)).size
  end
  
  def test_should_require_number_be_exactly_10_numbers
    phone_number = new_phone_number(:number => '1' * 9)
    assert !phone_number.valid?
    assert_equal 1, Array(phone_number.errors.on(:number)).size
    
    phone_number.number += '1'
    assert phone_number.valid?
    
    phone_number.number += '1'
    assert !phone_number.valid?
    assert_equal 1, Array(phone_number.errors.on(:number)).size
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
    assert_equal 1, Array(phone_number.errors.on(:extension)).size
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
  
  def test_should_generate_stringified_version_of_phone_number
    assert_equal '1- 1234567890', @phone_number.to_s
  end
end

class PhoneNumberWithExtensionTest < Test::Unit::TestCase
  def setup
    @phone_number = create_phone_number(:country_code => '1', :number => '1234567890', :extension => '123')
  end
  
  def test_should_generate_stringified_version_of_phone_number
    assert_equal '1- 1234567890 ext. 123', @phone_number.to_s
  end
end
