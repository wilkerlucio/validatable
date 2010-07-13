require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

unit_tests do
  def setup
    Validatable::I18n.enable
  end
  
  def teardown
    Validatable::I18n.disable
  end
  
  test "generation of defaults" do
    assert_equal [:"models.my_model.attributes.my_attribute.my_label", :"models.my_model.my_label", :"messages.my_label"], Validatable::I18n.build_defaults("my_model", "my_attribute", "my_label")
  end
  
  test "get direct translation" do
    assert_equal "Tu position!", Validatable::I18n.translate("user", "name", "blank")
  end
  
  test "get by model" do
    assert_equal "Preenche!", Validatable::I18n.translate("user", "other", "blank")
  end

  test "get by message" do
    assert_equal "say something!", Validatable::I18n.translate("thing", "other", "blank")
  end
  
  test "get nil if not found" do
    assert_equal nil, Validatable::I18n.translate("thing", "other", "nonset")
  end
end