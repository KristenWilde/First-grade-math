require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get root_path
    assert_response :success
    assert_routing "/", controller: 'pages', action: 'main'
  end

  test "root_path should show wrapper" do
    get root_path
    assert_select '#wrapper', 1, 'Does not show wrapper element'
  end
end
