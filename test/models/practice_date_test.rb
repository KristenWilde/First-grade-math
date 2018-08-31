require 'test_helper'
require 'pry'

class PracticeDateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @bob = User.create(username: 'Bob', password: 'password')
  end

  test "won't create an invalid practice record" do
    invalid = PracticeDate.new(problems_answered: 'word', seconds: 'string', user_id: @bob.id)
    empty = PracticeDate.new()
    assert_not invalid.save, 'saved an invalid practice record'
    assert_not empty.save, 'saved an practice record without data'
  end

  test 'will create a valid practice record' do
    valid = PracticeDate.new(problems_answered: 5, seconds: 30, user_id: @bob.id)
    assert valid.save, 'failed to save a valid practice record'
  end

  test "won't create more than one practice record per day" do
    flunk 'Validation of one per day has not been implemented'
  end
end
