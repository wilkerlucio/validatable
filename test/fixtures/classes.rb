unless defined? TEST_MODELS
  TEST_MODELS = true
  
  class Model1
    include Validatable
  
    attr_accessor :name
    validates_presence_of :name
  end
end
