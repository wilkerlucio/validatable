module Validatable
  class ValidatesTrueFor < ValidationBase #:nodoc:
    required_option :logic
  
    def valid?(instance)
      instance.instance_eval(&logic) == true
    end
    
    def message(instance)
      super || i18n_message(instance, :invalid) || "is invalid"
    end
  end
end