class DateRecord < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'

  def self.update_date_records(user, seconds, num_problems)
    record = today_record(user)
    new_seconds = record.seconds + seconds.to_i;
    new_problems = record.problems_answered + num_problems.to_i
    record.update(seconds: new_seconds, problems_answered: new_problems)
  end

  def self.today_record(user)
    record = user.date_records.find_by(created_at: Time.now.midnight..Time.now)
    unless record
      record = DateRecord.create(user_id: user.id)
    end
    record
  end
end
