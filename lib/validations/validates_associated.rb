module Validatable
  class ValidatesAssociated < ValidationBase #:nodoc:
    def valid?(instance)
      Array(instance.send(attribute)).compact.map do |child|
        child.valid?
      end.all?
    end

    def message(instance)
      super || i18n_message(instance, :invalid) || "is invalid"
    end
  end
end
