require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

module Functional
  class I18nTest < Test::Unit::TestCase
    def setup
      Validatable::I18n.enable
    end
    
    def teardown
      Validatable::I18n.disable
    end
    
    test "validates presence of custom validation" do
      instance = Model1.new
      instance.valid?
      
      assert_equal "model name required", instance.errors.on(:name)
    end
    
    test "validates acceptance error message" do
      klass = Class.new do
        include Validatable
        attr_accessor :name
        validates_acceptance_of :name
      end
      instance = klass.new
      instance.valid?
      assert_equal "agree!", instance.errors.on(:name)
    end
    
    test "validates associated error message" do
      parent = Class.new do
        include Validatable
        attr_accessor :children
        validates_associated :children
      end
      
      child = Class.new do
        include Validatable
        attr_accessor :name
        validates_presence_of :name
      end
      
      instance = parent.new
      instance.children = [child.new]
      instance.valid?
      assert_equal "is not aceptable!", instance.errors.on(:children)
    end
    
    test "validates confirmation error message" do
      klass = Class.new do
        include Validatable
        attr_accessor :name
        validates_confirmation_of :name
      end
      instance = klass.new
      instance.name = "foo"
      instance.name_confirmation = "bar"
      instance.valid?
      assert_equal "is not what I want!", instance.errors.on(:name)
    end
    
    test "validates format error message" do
      klass = Class.new do
        include Validatable
        attr_accessor :name
        validates_format_of :name, :with => /.+/
      end
      instance = klass.new
      instance.valid?
      assert_equal "is not aceptable!", instance.errors.on(:name)
    end
    
    test "validates length error message" do
      klass = Class.new do
        include Validatable
        attr_accessor :name
        validates_length_of :name, :minimum => 2
      end
      instance = klass.new
      instance.valid?
      assert_equal "is not aceptable!", instance.errors.on(:name)
    end
    
    test "validates numericality error message" do
      klass = Class.new do
        include Validatable
        attr_accessor :nothing
        validates_numericality_of :nothing
      end
      instance = klass.new
      instance.valid?
      assert_equal "just numbers!", instance.errors.on(:nothing)
    end
    
    test "validates presence error message" do
      klass = Class.new do
        include Validatable
        attr_accessor :name
        validates_presence_of :name
      end
      instance = klass.new
      instance.valid?
      assert_equal "say something!", instance.errors.on(:name)
    end
    
    test "validates true error message" do
      klass = Class.new do
        include Validatable
        attr_accessor :name
        validates_true_for :name, :logic => lambda { name == "nombre" }
      end
      instance = klass.new
      instance.valid?
      assert_equal "is not aceptable!", instance.errors.on(:name)
    end
  end
end
