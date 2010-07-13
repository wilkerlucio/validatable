module Validatable
  module I18n
    DEFAULT_SCOPE = :"activerecord.errors"
    
    PATHS = [
      "models.{{model_name}}.attributes.{{attribute_name}}.{{label_name}}",
      "models.{{model_name}}.{{label_name}}",
      "messages.{{label_name}}"
    ]
    
    class << self
      @enabled = true
      
      def build_defaults(model_name, attribute_name, label_name)
        PATHS.map do |scope|
          path = scope.dup
          path.gsub! '{{model_name}}', model_name.to_s
          path.gsub! '{{attribute_name}}', attribute_name.to_s
          path.gsub! '{{label_name}}', label_name.to_s
          path.to_sym
        end
      end
      
      def translate(model_name, attribute_name, label_name)
        return nil unless enabled?
        
        defaults = build_defaults(model_name, attribute_name, label_name)
        
        defaults.each do |scope|
          begin
            message = ::I18n.translate!(scope, :scope => DEFAULT_SCOPE)
            return message
          rescue
          end
        end
        
        nil
      end
      
      alias :t :translate
      
      def enabled?
        @enabled
      end
      
      def enable
        @enabled = true
      end
      
      def disable
        @enabled = false
      end
    end
  end
end