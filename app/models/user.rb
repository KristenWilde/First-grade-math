class User < ApplicationRecord

  has_many :practice_dates
  has_many :problems

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  after_create do
    build_problem_set
  end

  def to_param
    username
  end

  private

    def build_problem_set
      (4..20).each do |minuend|
        (2..10).each do |subtrahend|
          if (1..10).include? (minuend - subtrahend)
            Problem.create(user_id: self.id, minuend: minuend, subtrahend: subtrahend, success_times: 0)
          end
        end
      end
    end

end
