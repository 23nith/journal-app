require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "should not save User without a title" do
    @category = Category.new
    @category.description = "Wala akong title."
    
    assert_not @category.save, "Saved the category without title."
  end
end

