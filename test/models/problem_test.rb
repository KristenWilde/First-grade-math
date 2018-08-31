require 'test_helper'
require 'pry'

class ProblemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @bob = User.create(username: 'Bob', password: 'password')
  end

  test "test update_problems method for multiple problems" do
    id_1, id_2 = @bob.problems.take(2).map(&:id)
    data = [ { 'id' => id_1, 'success_times' => 3},
             { 'id' => id_2, 'success_times' => 4} ]
    Problem.update_problems(data)
    assert_equal 3, Problem.find_by_id(id_1).success_times, 'Did not update problem'
    assert_equal 4, Problem.find_by_id(id_2).success_times, 'Did not update problem'
  end

end
