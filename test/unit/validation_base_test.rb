require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ValidationBaseTest < Test::Unit::TestCase
  expect true do
    validation = Validatable::ValidationBase.new :base
    validation.should_validate? Object.new
  end
  
  expect true do
    validation = Validatable::ValidationBase.new :base, nil, nil, 1
    validation.validate_this_time?
  end
  
  expect true do
    validation = Validatable::ValidationBase.new :base
    validation.validate_this_time?
  end
  
  expect true do
    validation = Validatable::ValidationBase.new :base, nil, nil, 2
    validation.validate_this_time?
    validation.validate_this_time?
  end

  expect false do
    validation = Validatable::ValidationBase.new :base, nil, nil, 1
    validation.validate_this_time?
    validation.validate_this_time?
  end
end