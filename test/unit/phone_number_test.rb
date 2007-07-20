require File.dirname(__FILE__) + '/../test_helper'

class PhoneNumberTest < Test::Unit::TestCase
  fixtures :phone_numbers
  
  def test_should_be_valid
    assert_valid phone_numbers(:cell)
  end
  
  def test_should_require_phoneable_id
    assert_invalid phone_numbers(:cell), 'phoneable_id', nil
  end
  
  def test_should_require_phoneable_type
    assert_invalid phone_numbers(:cell), 'phoneable_type', nil
  end
  
  def test_should_require_country_code
    assert_invalid phone_numbers(:cell), 'country_code', nil
  end
  
  def test_should_require_number
    assert_invalid phone_numbers(:cell), 'number', nil
  end
  
  def test_should_require_country_code_be_a_number
    assert_invalid phone_numbers(:cell), 'country_code', 'invalid', '123invalid'
  end
  
  def test_should_require_number_be_a_number
    assert_invalid phone_numbers(:cell), 'number', 'invalid', '123invalid'
  end
  
  def test_should_require_extension_be_a_number
    assert_invalid phone_numbers(:cell), 'extension', 'invalid', '123invalid'
  end
  
  def test_should_restrict_country_code_length
    assert_invalid phone_numbers(:cell), 'extension', 'invalid', '123invalid'
  end
  
  def test_should_restrict_number_length
    assert_invalid phone_numbers(:cell), 'number', '123', '12345678901'
    assert_valid phone_numbers(:cell), 'number', '1234567890'
  end
  
  def test_should_restrict_extension_length
    assert_invalid phone_numbers(:cell), 'extension', '12345678901'
    assert_valid phone_numbers(:cell), 'extension', '1', '123', '1234567890'
  end
  
  def test_should_allow_phoneable_to_be_of_any_type
    assert_valid phone_numbers(:cell), 'phoneable_type', 'House', 'Person'
  end
  
  def test_should_generate_stringified_version_of_phone_number
    assert_equal '1- 1234567890', phone_numbers(:cell).to_s
  end
  
  def test_should_generate_stringified_version_of_phone_number_with_extension
    assert_equal '1- 1234567891 ext. 123', phone_numbers(:work).to_s
  end
end