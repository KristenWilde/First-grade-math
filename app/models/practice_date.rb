class PracticeDate < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  validates :seconds, :problems_answered, numericality: true, presence: true
  validates :created_at, numericality: true, presence: true, uniqueness: true

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
