require 'test_helper'
require 'pry'

class PracticeDateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @bob = User.create(username: 'Bob', password: 'password')
  end

  test "won't create an invalid practice record" do #fails
    invalid = PracticeDate.new(problems_answered: 'word', seconds: 'string', user_id: @bob.id)
    assert_not invalid.save, 'saved an invalid practice record'
  end

  test 'will create a valid prace record' do
    valid = PracticeDate.new(problems_answered: 5, seconds: 30, user_id: @bob.id)
    assert valid.save, 'failed to save a valid practice record'
  end

  test "won't create more than one practice record per day" do #fails
    record1 = PracticeDate.create
    assert_not PracticeDate.create, 'saved two records created on same date'
  end
end
