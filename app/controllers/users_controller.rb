class UsersController < ApplicationController
  before_action :require_session, only: [:show, :edit, :update, :date_records]

  def show
    @problems = @user.problems
    @username = @user.username

    @secondsToday = today_record(@user).seconds
    @problemsToday = today_record(@user).problems_answered
  end

  def create
    user = User.create(username: params[:username], password: params[:password])
    session[:user_id] = user.id
    redirect_to user_path(user)
  end

  def update
    problems_to_update = params[:problems]
    seconds = params[:seconds]
    num_problems = params[:reps]

    update_problems(problems_to_update)
    update_date_records(@user, seconds, num_problems)
    render json: today_record(@user)
  end

  def available
    user = User.find_by username: params[:username]
    render plain: !user
  end

  def date_records
    render json: @user.date_records
  end

  private

    def update_problems(problems_to_update)
      problems_to_update.each do |prob|
        record = Problem.find_by id: prob['id']
        record.update success_times: prob['success_times']
      end
    end

    def update_date_records(user, seconds, num_problems)
      record = today_record(user)
      new_seconds = record.seconds + seconds.to_i;
      new_problems = record.problems_answered + num_problems.to_i
      record.update(seconds: new_seconds, problems_answered: new_problems)
    end

    def today_record(user)
      record = user.date_records.find_by(created_at: Time.now.midnight..Time.now)
      unless record
        record = DateRecord.create(user_id: user.id)
      end
      record
    end
end
