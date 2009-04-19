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
  
  def test_should_require_a_known_country_code
    phone_number = new_phone_number(:country_code => '2')
    assert !phone_number.valid?
    assert phone_number.errors.invalid?(:country_code)
    
    phone_number.country_code = '1'
    assert phone_number.valid?
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
  
  def test_should_require_number_be_exact_for_country_code_without_range
    phone_number = new_phone_number(:country_code => '1', :number => '1' * 9)
    assert !phone_number.valid?
    assert_equal 'is the wrong length (should be 10 characters)', phone_number.errors.on(:number)
    
    phone_number.number += '1'
    assert phone_number.valid?
    
    phone_number.number += '1'
    assert !phone_number.valid?
    assert_equal 'is the wrong length (should be 10 characters)', phone_number.errors.on(:number)
  end
  
  def test_should_require_number_be_within_range_for_country_code_with_range
    phone_number = new_phone_number(:country_code => '32', :number => '1' * 7)
    assert !phone_number.valid?
    assert_equal 'is too short (minimum is 8 characters)', phone_number.errors.on(:number)
    
    phone_number.number += '1'
    assert phone_number.valid?
    
    phone_number.number += '1'
    assert phone_number.valid?
    
    phone_number.number += '1'
    assert !phone_number.valid?
    assert_equal 'is too long (maximum is 9 characters)', phone_number.errors.on(:number)
  end
  
  def test_should_not_require_an_extension
    phone_number = new_phone_number(:extension => nil)
    assert phone_number.valid?
  end
  
  def test_should_require_extension_be_at_most_10_digits
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

class PhoneNumberParserTest < Test::Unit::TestCase
  def setup
    @person = create_person
    @phone_number = new_phone_number(:phoneable => @person, :country_code => nil, :number => nil, :extension => nil)
  end
  
  def test_should_parse_country_code_with_1_digit
    @phone_number.content = '11234567890'
    
    assert @phone_number.valid?
    assert_equal '1', @phone_number.country_code
    assert_equal '1234567890', @phone_number.number
    assert_nil @phone_number.extension
  end
  
  def test_should_parse_country_code_with_2_digits
    @phone_number.content = '20123456789'
    
    assert @phone_number.valid?
    assert_equal '20', @phone_number.country_code
    assert_equal '123456789', @phone_number.number
    assert_nil @phone_number.extension
  end
  
  def test_should_parse_country_code_with_3_digits
    @phone_number.content = '21212345678'
    
    assert @phone_number.valid?
    assert_equal '212', @phone_number.country_code
    assert_equal '12345678', @phone_number.number
    assert_nil @phone_number.extension
  end
  
  def test_should_parse_number_with_spaces
    @phone_number.content = '1 123 456 7890'
    
    assert @phone_number.valid?
    assert_equal '1', @phone_number.country_code
    assert_equal '1234567890', @phone_number.number
    assert_nil @phone_number.extension
  end
  
  def test_should_parse_number_with_dashes
    @phone_number.content = '1-123-456-7890'
    
    assert @phone_number.valid?
    assert_equal '1', @phone_number.country_code
    assert_equal '1234567890', @phone_number.number
    assert_nil @phone_number.extension
  end
  
  def test_should_parse_number_with_parentheses
    @phone_number.content = '1- (123) 456-7890'
    
    assert @phone_number.valid?
    assert_equal '1', @phone_number.country_code
    assert_equal '1234567890', @phone_number.number
    assert_nil @phone_number.extension
  end
  
  def test_should_parse_number_with_leading_zero
    @phone_number.content = '011234567890'
    
    assert @phone_number.valid?
    assert_equal '1', @phone_number.country_code
    assert_equal '1234567890', @phone_number.number
    assert_nil @phone_number.extension
  end
  
  def test_should_parse_number_with_multiple_leading_zeroes
    @phone_number.content = '0011234567890'
    
    assert @phone_number.valid?
    assert_equal '1', @phone_number.country_code
    assert_equal '1234567890', @phone_number.number
    assert_nil @phone_number.extension
  end
  
  def test_should_parse_extension_with_leading_ext
    @phone_number.content = '11234567890 ext. 123'
    
    assert @phone_number.valid?
    assert_equal '1', @phone_number.country_code
    assert_equal '1234567890', @phone_number.number
    assert_equal '123', @phone_number.extension
  end
  
  def test_should_parse_extension_with_leading_ex
    @phone_number.content = '11234567890 ex:123'
    
    assert @phone_number.valid?
    assert_equal '1', @phone_number.country_code
    assert_equal '1234567890', @phone_number.number
    assert_equal '123', @phone_number.extension
  end
  
  def test_should_parse_extension_with_leading_xt
    @phone_number.content = '11234567890 xt: 123'
    
    assert @phone_number.valid?
    assert_equal '1', @phone_number.country_code
    assert_equal '1234567890', @phone_number.number
    assert_equal '123', @phone_number.extension
  end
  
  def test_should_parse_extension_with_leading_x
    @phone_number.content = '11234567890 x.  123'
    
    assert @phone_number.valid?
    assert_equal '1', @phone_number.country_code
    assert_equal '1234567890', @phone_number.number
    assert_equal '123', @phone_number.extension
  end
  
  def test_should_parse_extension_with_mixed_case
    @phone_number.content = '11234567890 xT 123'
    
    assert @phone_number.valid?
    assert_equal '1', @phone_number.country_code
    assert_equal '1234567890', @phone_number.number
    assert_equal '123', @phone_number.extension
  end
  
  def test_should_not_be_valid_if_parse_fails
    @phone_number.content = '1123456789'
    
    assert !@phone_number.valid?
    assert_equal '1', @phone_number.country_code
    assert_equal '123456789', @phone_number.number
    assert_nil @phone_number.extension
  end
end

class PhoneNumberParserWithDefaultCountryCodeTest < Test::Unit::TestCase
  def setup
    PhoneNumber.use_default_country_code_on_parse = true
    
    @person = create_person
    @phone_number = new_phone_number(:phoneable => @person, :content => '7234567890 ex. 12')
    @valid = @phone_number.valid?
  end
  
  def test_should_be_valid
    assert @valid
  end
  
  def test_should_use_default_country_code
    assert_equal '1', @phone_number.country_code
  end
  
  def test_should_parse_number
    assert_equal '7234567890', @phone_number.number
  end
  
  def test_should_parse_extension
    assert_equal '12', @phone_number.extension
  end
  
  def teardown
    PhoneNumber.use_default_country_code_on_parse = false
  end
end
