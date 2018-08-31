require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create(username: 'Bob', password: 'password')
  end

  test "creates a user with valid data" do
    assert User.find_by_username('Bob'), "User Bob does not exist"
  end

  test "won't create a user with invalid data" do
    duplicate_name = User.new(username: 'Bob', password: 'password1')
    bad_password = User.new(username: 'Maya', password: 'short')
    assert_not duplicate_name.save, 'Created user with already existing username'
    assert_not bad_password.save, 'Created user with password too short'
  end

  test "user has 89 problems" do
    num_problems = @user.problems.size
    assert_equal num_problems, 89, "User has #{num_problems} problems, not 89"
  end
end
