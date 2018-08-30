class PracticeDate < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'

  def self.update_practice(user, seconds, reps)
    values = {
      seconds: current_practice(user).seconds + seconds.to_i,
      problems_answered: current_practice(user).problems_answered + reps.to_i
    }
    current_practice(user).update(values)
  end

  def self.current_practice(user)
    find_or_create_by(created_at: Time.now.midnight..Time.now, user_id: user.id)
  end
end
