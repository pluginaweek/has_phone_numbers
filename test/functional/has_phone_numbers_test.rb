require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class PersonByDefaultTest < Test::Unit::TestCase
  def setup
    @person = create_person
  end
  
  def test_should_not_have_any_phone_numbers
    assert @person.phone_numbers.empty?
  end
end

class PersonWithPhoneNumbersTest < Test::Unit::TestCase
  def setup
    @person = create_person
    @phone_number = create_phone_number(:phoneable => @person)
  end
  
  def test_should_have_phone_numbers
    assert_equal [@phone_number], @person.phone_numbers
  end
end
