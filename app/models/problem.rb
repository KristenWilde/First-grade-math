class Problem < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'

  def self.update_problems(problems_to_update)
    problems_to_update.each do |prob|
      record = Problem.find_by id: prob['id']
      record.update success_times: prob['success_times']
    end
  end
end
