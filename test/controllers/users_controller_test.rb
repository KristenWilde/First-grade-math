require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "create new user" do

    assert_response :success
    assert_routing "/", controller: 'pages', action: 'main'
  end


end
