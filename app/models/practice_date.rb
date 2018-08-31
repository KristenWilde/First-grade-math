class PracticeDate < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  validates :seconds, :problems_answered, numericality: true, presence: true

  def self.add_to_practice(user, seconds, reps)
    values = {
      seconds: current_practice(user).seconds + Integer(seconds),
      problems_answered: current_practice(user).problems_answered + Integer(reps)
    }
    current_practice(user).update(values)
  end

  def self.current_practice(user)
    find_or_create_by(created_at: Time.now.midnight..Time.now, user_id: user.id)
  end
end
