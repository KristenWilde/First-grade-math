require "application_system_test_case"
require 'pry'

class UsersTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit users_url
  #
  #   assert_selector "h1", text: "Users"
  # end

  test "Visit the sign-in/register page" do
    visit root_path
    assert_selector 'main', count: 1
    assert_selector 'nav > a', count: 2
    assert_selector '#register', visible: false
    assert_selector '#login', visible: false

    find('#show-sign-up').trigger('click')
    assert_selector '#register', visible: true
    assert_selector '#login', visible: false

    find('#show-log-in').trigger('click')
    assert_selector '#register', visible: false
    assert_selector '#login', visible: true
  end


end
